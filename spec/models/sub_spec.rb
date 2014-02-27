require 'spec_helper'

describe Sub do
  let(:new_sub) {FactoryGirl.build(:sub)}

  describe "Attributes" do
    it "should have a name" do
      new_sub.name = ''
      expect(new_sub).not_to be_valid
    end

    it "name should be at least 3 letters" do
      new_sub.name = 'a' * 2
      expect(new_sub).not_to be_valid

      new_sub.name = 'a' * 3
      expect(new_sub).to be_valid
    end

    it "should have a moderator" do
      new_sub.mod_id = ""
      expect(new_sub).not_to be_valid
    end
  end

  describe "Associations" do
    it { should have_many(:links)}
    it { should belong_to(:moderator)}
  end

end

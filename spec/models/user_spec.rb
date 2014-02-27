require 'spec_helper'

describe User do
  let(:new_user) { FactoryGirl.build(:user) }

  describe "User Creation" do
    it "should have a valid username" do
      new_user.username = ""
      expect(new_user).not_to be_valid
    end

    it "should have a unique username" do
      new_user.username = "foobar"
      new_user.save!
      new_user2 = FactoryGirl.build(:user, :username => "foobar")
      expect(new_user2).not_to be_valid
    end

    it "should have a valid password" do
      new_user.password = ""
      expect(new_user).not_to be_valid
    end

    it "should not store a plaintext password" do
      new_user.save!
      expect(User.find(new_user).password).to be_nil
    end

    it "should have a token" do
      expect(new_user.token).not_to be_nil
    end
  end

  describe "User Model Functions" do

    describe "Password functions" do
      it "should have password setter method" do
        expect{new_user.password = Faker::Internet.user_name}.to change{new_user.password_digest}
      end

      it "should return true if the password decrypts to the digest" do
        expect(new_user.is_password?("not_a_real_password")).to be_false
        expect(new_user.is_password?(new_user.password)).to be_true
      end
    end

    describe "User class methods" do
      it "should find user by credentials" do

        new_user.save!
        expect(User.find_by_credentials(new_user)).to eq(new_user)
        expect(User.find_by_credentials(new_user)).not_to eq(User.new)
      end

    end
  end


end

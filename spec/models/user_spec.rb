require 'spec_helper'

describe User do

  describe "User attributes presence" do

    it "should have a valid username" do
      empty_user = User.new(:username => "", :password_digest => "sadfasdfasdf", :token => 'token')
      expect(empty_user).not_to be_valid
    end

    it "should have a unique username" do
      empty_user1 = User.create!(:username => "hello_world", :password_digest => "foobar1", :token => 'token')
      empty_user2 = User.new(:username => "hello_world", :password_digest => "foobar2", :token => 'token')
      expect(empty_user2).not_to be_valid
    end

    it "should have a valid password" do
      empty_user = User.new(:username => "real_user", :password_digest => "", :token => 'token')
      expect(empty_user).not_to be_valid
    end

    it "should have a token" do
      empty_user = User.new(:username => "real_user", :password_digest => "blah", :token => '')
      expect(empty_user).not_to be_valid
    end
  end


end

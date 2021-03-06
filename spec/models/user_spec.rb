require 'spec_helper'

describe User do

  before(:each) do
    WebMock.reset!
    stub_geezeo_api_requests

    @user = User.new('123', 'some_token')
  end

  describe "creation" do

    it "should assign the user_id" do
      @user.user_id.should == '123'
    end

    it "should assign the token" do
      @user.token.should == 'some_token'
    end
  end

  describe "#valid?" do

    it "should have a #valid? method to check that the user_id/token combo is valid" do
      @user.should respond_to(:valid?)
    end

    it "should perform a HEAD request to the accounts api to check the credintials" do
      @user.valid?
      a_request_of_accounts_for(@user).should have_been_made
    end
  end

  describe "#accounts" do

    it "should have requested this user's accounts" do
      @user.accounts
      a_request_of_accounts_for(@user).should have_been_made
    end

    it "should only request the accounts once when called multiple times" do
      @user.accounts
      @user.accounts
      a_request_of_accounts_for(@user).should have_been_made.once
    end

    it "should return an array of Accounts" do
      @user.accounts.should respond_to(:each)
      @user.accounts.first.should be_kind_of(Account)
    end
  end
end
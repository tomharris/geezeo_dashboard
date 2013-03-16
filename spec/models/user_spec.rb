require 'spec_helper'

describe User do

  describe "creation" do

    it "should assign the user_id" do
      User.new('1', 'some_token').user_id.should == '1'
    end

    it "should assign the token" do
      User.new('1', 'some_token').token.should == 'some_token'
    end
  end

  describe "#valid?" do

    it "should have a #valid? method to check that the user_id/token combo is valid" do
      User.new('1', 'some_token').should respond_to(:valid?)
    end

    it "should perform a HEAD request to the accounts api to check the credintials" do
      response = mock("mock response")
      response.stub!(:success?).and_return(true)
      User.should_receive(:head).with('/users/123/accounts', hash_including({ basic_auth: { username: 'some_token' } })).and_return(response)

      User.new('123', 'some_token').valid?
    end
  end
end
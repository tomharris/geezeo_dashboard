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
end
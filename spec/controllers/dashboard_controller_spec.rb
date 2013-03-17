require 'spec_helper'

describe DashboardController do

  def valid_session
    {
      user_id: '123',
      token: 'some_token'
    }
  end

  before(:each) do
    WebMock.reset!
    stub_geezeo_api_requests

    @user = User.new(valid_session[:user_id], valid_session[:token])
  end

  describe "GET show" do

    def do_get
      get :show, {}, valid_session
    end

    it "should assign the current user to user" do
      do_get

      assigns(:user).should_not be_nil
      assigns(:user).user_id.should == valid_session[:user_id]
      assigns(:user).token.should == valid_session[:token]
    end

    it "should assign the current user's accounts to accounts" do
      do_get

      assigns(:accounts).should_not be_nil
      assigns(:accounts).should_not be_empty
    end

    it "should assign the first group of transactions for the current user's first account to transactions" do
      do_get

      assigns(:transactions).should_not be_nil
      assigns(:transactions).should_not be_empty
    end
  end
end

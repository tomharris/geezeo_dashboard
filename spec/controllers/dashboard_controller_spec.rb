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

    def do_get(options = {})
      get :show, options, valid_session
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

    it "should assign the total of all account balances" do
      do_get

      assigns(:account_balance_total).should == 2_070.42 # total from the account fixtures
    end

    it "should assign the current user's first account to selected_account by default if one isn't specified" do
      do_get

      assigns(:selected_account).should_not be_nil
      assigns(:selected_account).should == assigns(:accounts).first
    end

    it "should assign the first group of transactions for the selected_account to transactions" do
      do_get

      assigns(:transactions).should_not be_nil
      assigns(:transactions).should_not be_empty
      assigns(:transactions).should == assigns(:selected_account).transactions
    end

    it "should assign the account specified by the 'account_id' param" do
      # '4369563' is the second account in the 'accounts_api_response.txt' fixture
      do_get('account_id' => '4369563')

      assigns(:selected_account).id.should == 4369563
    end
  end
end

require 'spec_helper'

describe Account do

  before(:each) do
    WebMock.reset!
    stub_geezeo_api_requests

    @user = User.new('123', 'some_token')
  end

  it "should have the right fields" do
    %w(id name balance reference_id aggregation_type state).each do |field_name|
      Account.new.should respond_to(field_name)
    end
  end

  describe "::from_hash" do

    it "should turn the attributes into an instance" do
      Account.from_hash(valid_account_attributes).should be_instance_of(Account)
    end

    it "should set the fields in the instance to the values in the attributes" do
      instance = Account.from_hash(valid_account_attributes)
      instance.id.should                == 123
      instance.name.should              == 'my account'
      instance.balance.should           == 10.01
      instance.reference_id.should      == '12'
      instance.aggregation_type.should  == 'partner'
      instance.state.should             == 'active'
    end
  end

  describe "::find_all_for" do

    it "should perform a GET request to the accounts api to fetch the accounts" do
      Account.find_all_for(@user)
      a_request_of_accounts_for(@user).should have_been_made
    end

    it "should also assign the user to an accessor" do
      Account.find_all_for(@user).first.user.should == @user
    end
  end

  describe "#transactions" do

    before(:each) do
      @account = Account.new.tap { |a| a.id = '321'; a.user = @user }
    end

    it "should return a proxie to handle pagination" do
      @account.transactions.should be_kind_of(RemoteAssociationPaginationProxie)
    end

    it "should have requested this account's transactions" do
      @account.transactions.fetch
      a_request_of_transactions_for(@user, @account).should have_been_made
    end

    it "should only request the accounts once when called multiple times" do
      @account.transactions.fetch
      @account.transactions.fetch
      a_request_of_transactions_for(@user, @account).should have_been_made.once
    end

    it "should return an array of Transaction" do
      @account.transactions.should respond_to(:each)
      @account.transactions.first.should be_kind_of(Transaction)
    end
  end
end
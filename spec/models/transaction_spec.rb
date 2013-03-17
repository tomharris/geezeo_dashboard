require 'spec_helper'

describe Transaction do

  it "should have the right fields" do
    %w(id transaction_type memo balance posted_at created_at nickname original_name tags).each do |field_name|
      Transaction.new.should respond_to(field_name)
    end
  end

  describe "::from_hash" do

    it "should turn the attributes into an instance" do
      Transaction.from_hash(valid_transaction_attributes).should be_instance_of(Transaction)
    end

    it "should set the fields in the instance to the values in the attributes" do
      instance = Transaction.from_hash(valid_transaction_attributes)
      instance.id.should                == 'bd123b4b-7b33-46d9-a77f-5efc525f67c5'
      instance.transaction_type.should  == 'Debit'
      instance.memo.should              == 'Check #123'
      instance.balance.should           == 61.01
      instance.posted_at.should         == Time.parse('2013-03-13T00:00:00+00:00')
      instance.created_at.should        == Time.parse('2013-03-13T19:36:53+00:00')
      instance.nickname.should          == 'Check #123'
      instance.original_name.should     == 'Check #123'
      instance.tags.should              == [{ 'tag' => { 'name' => "Personal", 'balance' => 61.01 } }]
    end
  end

  describe "::find_all_for" do

    before(:each) do
      WebMock.reset!
      stub_geezeo_api_requests

      @user = User.new('123', 'some_token')
      @account = Account.new.tap { |a| a.id = '321' }
    end

    it "should perform a GET request to the transactions api to fetch the transactions" do
      Transaction.find_all_for(@user, @account).fetch
      a_request_of_transactions_for(@user, @account).should have_been_made
    end

    it "should total_pages for the request" do
      transactions = Transaction.find_all_for(@user, @account).fetch
      transactions.total_pages.should == 6
    end
  end

  describe "#credit?" do

    it "should indicate when a transaction was a credit" do
      transaction = Transaction.new.tap { |a| a.transaction_type = 'Credit' }
      transaction.should be_credit
    end
  end

  describe "#debit?" do

    it "should indicate when a transaction was a debit" do
      transaction = Transaction.new.tap { |a| a.transaction_type = 'Debit' }
      transaction.should be_debit
    end
  end
end
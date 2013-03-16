require 'spec_helper'

describe Transaction do

  it "should have the right fields" do
    %w(id transaction_type memo balance posted_at created_at nickname original_name tags).each do |field_name|
      Transaction.new.should respond_to(field_name)
    end
  end

  describe "::from_hash" do

    before(:each) do
      @attributes = {
        'id'                => 'bd123b4b-7b33-46d9-a77f-5efc525f67c5',
        'transaction_type'  => 'Debit',
        'memo'              => 'Check #123',
        'balance'           => 61.01,
        'posted_at'         => '2013-03-13T00:00:00+00:00',
        'created_at'        => '2013-03-13T19:36:53+00:00',
        'nickname'          => 'Check #123',
        'original_name'     => 'Check #123',
        'tags'              => [{ 'tag' => { 'name' => "Personal", 'balance' => 61.01 } }]
      }
    end

    it "should turn the attributes into an instance" do
      Transaction.from_hash(@attributes).should be_instance_of(Transaction)
    end

    it "should set the fields in the instance to the values in the attributes" do
      instance = Transaction.from_hash(@attributes)
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
      @user = User.new('123', 'some_token')
      @account = Account.new.tap { |a| a.id = '321' }
    end

    it "should perform a GET request to the transactions api to fetch the transactions" do
      response = mock("mock response").as_null_object
      Transaction.should_receive(:get).with('/users/123/accounts/321/transactions', hash_including({ basic_auth: { username: 'some_token' } })).and_return(response)

      Transaction.find_all_for(@user, @account)
    end
  end
end
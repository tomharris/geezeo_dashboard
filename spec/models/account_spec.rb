require 'spec_helper'

describe Account do

  it "should have the right fields" do
    %w(id name balance reference_id aggregation_type state).each do |field_name|
      Account.new.should respond_to(field_name)
    end
  end

  describe "::from_hash" do

    before(:each) do
      @attributes = {
        'id'                => 123,
        'name'              => 'my account',
        'balance'           => 10.01,
        'reference_id'      => '12',
        'aggregation_type'  => 'partner',
        'state'             => 'active'
      }
    end

    it "should turn the attributes into an instance" do
      Account.from_hash(@attributes).should be_instance_of(Account)
    end

    it "should set the fields in the instance to the values in the attributes" do
      instance = Account.from_hash(@attributes)
      instance.id.should                == 123
      instance.name.should              == 'my account'
      instance.balance.should           == 10.01
      instance.reference_id.should      == '12'
      instance.aggregation_type.should  == 'partner'
      instance.state.should             == 'active'
    end
  end

  describe "::find_all_for" do

    before(:each) do
      @user = User.new('123', 'some_token')
    end

    it "should perform a GET request to the accounts api to fetch the accounts" do
      response = mock("mock response").as_null_object
      Account.should_receive(:get).with('/users/123/accounts', hash_including({ basic_auth: { username: 'some_token' } })).and_return(response)

      Account.find_all_for(@user)
    end
  end
end
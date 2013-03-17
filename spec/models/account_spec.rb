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
      WebMock.reset!
      stub_geezeo_api_requests

      @user = User.new('123', 'some_token')
    end

    it "should perform a GET request to the accounts api to fetch the accounts" do
      Account.find_all_for(@user)
      a_request_of_accounts_for(@user).should have_been_made
    end
  end
end
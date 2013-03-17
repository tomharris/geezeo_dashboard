class Account
  include HTTParty
  attr_accessor :user, :id, :name, :balance, :reference_id, :aggregation_type, :state

  base_uri GeezeoDashboard::Application.config.geezeo_api_base_uri

  def self.resource_path_pattern; '/users/:user_id/accounts'; end

  def self.find_all_for(user)
    get(resource_path_pattern.gsub(':user_id', user.user_id), basic_auth: { username: user.token }).parsed_response['accounts'].collect do |attributes|
      from_hash(attributes).tap { |account| account.user = user }
    end
  end

  def self.from_hash(attributes)
    new.tap do |account|
      account.id                = attributes['id']
      account.name              = attributes['name']
      account.balance           = attributes['balance']
      account.reference_id      = attributes['reference_id']
      account.aggregation_type  = attributes['aggregation_type']
      account.state             = attributes['state']
    end
  end

  def transactions
    @transactions ||= Transaction.find_all_for(self.user, self)
  end
end
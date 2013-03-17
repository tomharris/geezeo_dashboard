class Transaction
  include HTTParty
  attr_accessor :id, :transaction_type, :memo, :balance, :posted_at, :created_at, :nickname, :original_name, :tags

  base_uri GeezeoDashboard::Application.config.geezeo_api_base_uri

  def self.resource_path_pattern; '/users/:user_id/accounts/:account_id/transactions'; end

  def self.find_all_for(user, account)
    response = get(resource_path_pattern.gsub(':user_id', user.user_id.to_s).gsub(':account_id', account.id.to_s), basic_auth: { username: user.token })

    response.parsed_response['transactions'].collect do |attributes|
      from_hash(attributes['transaction'])
    end
  end

  def self.from_hash(attributes)
    new.tap do |transaction|
      transaction.id                = attributes['id']
      transaction.transaction_type  = attributes['transaction_type']
      transaction.memo              = attributes['memo']
      transaction.balance           = attributes['balance']
      transaction.posted_at         = Time.parse(attributes['posted_at'])
      transaction.created_at        = Time.parse(attributes['created_at'])
      transaction.nickname          = attributes['nickname']
      transaction.original_name     = attributes['original_name']
      transaction.tags              = attributes['tags']
    end
  end
end
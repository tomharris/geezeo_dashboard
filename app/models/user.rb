class User
  include HTTParty
  attr_reader :user_id, :token

  base_uri GeezeoDashboard::Application.config.geezeo_api_base_uri

  def initialize(user_id, token)
    @user_id = user_id
    @token = token
  end

  def valid?
    self.class.head(Account.resource_path_pattern.gsub(':user_id', user_id), basic_auth: { username: @token }).success?
  end

  def accounts
    @accounts ||= Account.find_all_for(self)
  end
end
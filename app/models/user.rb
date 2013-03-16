class User
  include HTTParty
  attr_reader :user_id, :token

  base_uri GeezeoDashboard::Application.config.geezeo_api_base_uri

  def initialize(user_id, token)
    @user_id = user_id
    @token = token
  end

  def valid?
    self.class.head("/users/#{@user_id}/accounts", basic_auth: { username: @token }).success?
  end
end
module GeezeoApi
  module HttpRequestSupport

    def stub_geezeo_api_requests
      api_base_uri = URI(GeezeoDashboard::Application.config.geezeo_api_base_uri)

      # Stub for the accounts call
      accounts_request_pattern = Regexp.new(api_uri_pattern_for_resource(Account.resource_path_pattern).gsub(':token', '.*?').gsub(':user_id', '\d+'))
      stub_http_request(:any, accounts_request_pattern).
        to_return(File.read(Rails.root.join('spec', 'fixtures', 'accounts_api_response.txt')))

      # Stub for the transactions call
      transactions_request_pattern = Regexp.new(api_uri_pattern_for_resource(Transaction.resource_path_pattern).gsub(':token', '.*?').gsub(':user_id', '\d+').gsub(':account_id', '\d+'))
      stub_http_request(:any, transactions_request_pattern).
        to_return(File.read(Rails.root.join('spec', 'fixtures', 'transactions_api_response_page_1.txt')))
    end

    def a_request_of_accounts_for(user)
      a_request(:any, api_uri_pattern_for_resource(Account.resource_path_pattern).gsub(':token', user.token).gsub(':user_id', user.user_id))
    end

    def a_request_of_transactions_for(user, account)
      a_request(:any, api_uri_pattern_for_resource(Transaction.resource_path_pattern).gsub(':token', user.token).gsub(':user_id', user.user_id).gsub(':account_id', account.id))
    end

    private

    def api_uri_pattern_for_resource(path)
      # Webmock likes the basic auth user (the token) inserted into the url
      GeezeoDashboard::Application.config.geezeo_api_base_uri.gsub('://', '://:token:@') + path
    end
  end
end

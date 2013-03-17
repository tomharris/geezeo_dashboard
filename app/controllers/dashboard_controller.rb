class DashboardController < ApplicationController

  def show
    @user = current_user
    @accounts = @user.accounts

    if params['account_id']
      @selected_account = @accounts.select { |account| account.id.to_s == params['account_id'] }.first
    end

    @selected_account ||= @accounts.first
    @transactions = @selected_account.transactions
  end
end

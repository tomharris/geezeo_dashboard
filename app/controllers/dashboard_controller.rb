class DashboardController < ApplicationController

  def show
    @user = current_user
    @accounts = @user.accounts

    if params['account_id']
      @selected_account = @accounts.select { |account| account.id.to_s == params['account_id'] }.first
    end

    @page = params['page'].to_i
    @page = 1 if @page < 1

    @selected_account ||= @accounts.first
    @transactions = @selected_account.transactions.for_page(@page)
  end
end

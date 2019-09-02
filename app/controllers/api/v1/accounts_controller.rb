class Api::V1::AccountsController < ApplicationController

  before_action :permit_params

  def transaction_history
    data = Contexts::AccountHistory.call
    render data
  end

  private

  def account_param
    params.require(:account).permit(:account_id)

end

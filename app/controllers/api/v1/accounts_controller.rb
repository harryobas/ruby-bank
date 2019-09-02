class Api::V1::AccountsController < ApplicationController

  before_action :permit_params

  def transaction_history
    data = Contexts::AccountHistory.call(account_params[:account_id])
    render json: data
  end

  private

  def account_params
    params.require(:account).permit(:account_id)

end

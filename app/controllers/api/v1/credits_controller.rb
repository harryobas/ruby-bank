class Api::V1::CreditsController < ApplicationController

  skip_before_action :validate_token

  before_action :permit_params

  def add_credit
    amount = credit_params[:amount]
    account = credit_params[:account]

    data =  Contexts::UserCredit.call(account, amount)
    Rails.logger.debug.inspect data 
    render json: data
  end

  private

  def credit_params
    params.require(:credit).permit(:account, :amount)
  end

end

class Api::V1::TransfersController < ApplicationController

  skip_before_action :validate_token


  before_action :permit_params

  def transfer_funds
    sender = transfer_params[:sender]
    destination = transfer_params[:destination]
    amount = Float(transfer_params[:amount])

    data = Contexts::MoneyTransfer.call(sender, destination, amount)

    render json: data

  end

  private

  def transfer_params
    params.require(:transfer).permit(:sender, :destination, :amount)
  end

end

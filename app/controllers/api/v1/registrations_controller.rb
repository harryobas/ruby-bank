class Api::V1::RegistrationsController < ApplicationController

  skip_before_action :validate_token

  before_action :permit_params

  def create
    email = registration_params[:email]
    password = registration_params[:password]

    data = Contexts::UserRegister.call(email, password)
    render json: data
  end

  def registration_params
    params.require(:registration).permit(:email, :password)
  end

  def permit_params
    ActionController::Parameters.permit_all_parameters = true
  end


end

class Api::V1::SessionsController < ApplicationController
  skip_before_action :validate_token

  before_action :permit_params

  def create
    Rails.logger.debug params.inspect

    usr_email = session_params[:email]
    usr_password = session_params[:password]
    data = Contexts::UserLogin.call(usr_email, usr_password)
    render json: data
  end

  def session_params
    params.require(:login).permit(:email, :password)
  end

  def permit_params
    ActionController::Parameters.permit_all_parameters = true
  end

end

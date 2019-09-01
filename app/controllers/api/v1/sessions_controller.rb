class Api::V1::SessionsController < ApplicationController
  skip_before_action :validate_token

  before_action :permit_params

  def create

    usr_email = session_params[:email]
    usr_password = session_params[:password]
    data = Contexts::UserLogin.call(usr_email, usr_password)
    render json: data
  end

  private

  def session_params
    params.require(:login).permit(:email, :password)
  end


end

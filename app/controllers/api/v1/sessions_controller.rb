class Api::V1::SessionsController < ApplicationController
  skip_before_action :validate_token

  def create
    data = Contexts::UserLogin(params[:email], params[:password])
    render json: data
  end

end

class Api::V1::RegistrationsController < ApplicationController

  skip_before_action :validate_token

  def create
    if params[:password]
      data = Contexts::UserRegister.call(params[:password])
      render json: data
    else
      render json: {error: "missing data"}
    end
  end

end

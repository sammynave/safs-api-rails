# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def create
    command = AuthenticateUser.call(create_params[:email], create_params[:password])
    if command.success?
      response.set_cookie('jwt_access',
                          value: command.result,
                          httponly: true,
                          secure: Rails.env.production?)
      render status: :created
    else
      render json: { errors: command.errors }, status: :unauthorized
    end
  end

  def create_params
    params.require(:auth).permit(:email, :password)
  end
end

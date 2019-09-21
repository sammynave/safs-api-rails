# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def create
    handle_auth(create_params[:email], create_params[:password])
  end

  def create_params
    params.require(:auth).permit(:email, :password)
  end
end

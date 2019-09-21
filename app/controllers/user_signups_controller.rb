# frozen_string_literal: true

class UserSignupsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    user = User.new(user_params)

    return handle_auth(user_params[:email], user_params[:password]) if user.save

    respond_with_error(user.errors.full_messages)
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :phone)
  end
end

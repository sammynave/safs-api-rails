# frozen_string_literal: true

class UserSignupsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    user = User.new(user_params)

    if user.save
      command = AuthenticateUser.call(user_params[:email], user_params[:password])

      if command.success?
        response.set_cookie('jwt_access',
                            value: command.result,
                            httponly: true,
                            secure: Rails.env.production?)
      else
        return render json: { errors: [command.errors] },
                      status: :unprocessable_entity
      end

      render status: :created
    else
      render json: { errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :phone)
  end
end

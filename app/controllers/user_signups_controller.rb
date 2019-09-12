# frozen_string_literal: true

class UserSignupsController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)

      response.set_cookie('jwt_access',
                          value: token,
                          httponly: true,
                          secure: Rails.env.production?)
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

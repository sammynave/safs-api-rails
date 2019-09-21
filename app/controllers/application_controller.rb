# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.cookies).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def respond_with_cookie(jwt)
    response.set_cookie('jwt_access',
                        value: jwt,
                        httponly: true,
                        secure: Rails.env.production?)
    render status: :created
  end

  def respond_with_error(error)
    render json: { errors: error },
           status: :unprocessable_entity
  end

  def handle_auth(email, password)
    command = AuthenticateUser.call(email, password)
    return  respond_with_cookie(command.result) if command.success?

    respond_with_error([command.errors])
  end
end

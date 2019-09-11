class ApplicationController < ActionController::API
  before_action :get_current_user

  attr_reader :current_user

  private

  def get_current_user
    @current_user = AuthorizeApiRequest.call(request.headers).result
  end
end

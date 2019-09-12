class AuthenticationController < ApplicationController
 skip_before_action :get_current_user

 # logging out will require some thought
 # https://stackoverflow.com/questions/21978658/invalidating-json-web-tokens
 #
 # set http only cookie with jwt maybe. instead of passing around jwt in json

 def authenticate
   command = AuthenticateUser.call(params[:email], params[:password])

   if command.success?
     render json: { auth_token: command.result }
   else
     render json: { error: command.errors }, status: :unauthorized
   end
 end
end

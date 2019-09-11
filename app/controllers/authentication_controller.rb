class AuthenticationController < ApplicationController
 skip_before_action :authenticate_request

 # logging out will require some thought
 # https://stackoverflow.com/questions/21978658/invalidating-json-web-tokens

 def authenticate
   command = AuthenticateUser.call(params[:email], params[:password])

   if command.success?
     render json: { auth_token: command.result }
   else
     render json: { error: command.errors }, status: :unauthorized
   end
 end
end

class Api::V1::AuthenticationController < ApplicationController
 # skip_before_action :authenticate_request

 def authenticate
   command = AuthenticateUser.call(params[:email], params[:password])
   if command.success?
     render json: { auth_token: command.result }
   else
     render json: { error: command.errors }, status: :unauthorized
   end
 end
 def register
    visitor = Visitor.new(user_params)
    if visitor.save
      authenticate
    else
      render json: { error: visitor.errors.full_messages }, status: 500
    end
  end
end

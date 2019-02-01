class Api::V1::SessionsController < ApplicationController
  def new
  end
  #If user login data are valid it will return the access_token so the
  #client app can use it for future request for the specific user.
  def create
    user = Visitor.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        render json: {email: params[:session][:email], access_token: user.access_token}, status: 200
      else
        render json: "Email and password combination are invalid", status: 422
      end
  end

  def verify_access_token
    user = Visitor.find_by(access_token: params[:session][:access_token])
      if user
        render text: "verified", status: 200
      else
        render text: "Token failed verification", status: 422
      end
  end

end

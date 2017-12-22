class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # POST /signup
  def create
    user       = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.username, user.password).call
    response   = {
      message:    Message.account_created, 
      auth_token: auth_token,
      user:       user_params.except(:password) }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :username,
      :password
    )
  end
end

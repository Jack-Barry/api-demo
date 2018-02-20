class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def show 
    @user = current_user
    json_response({ user: @user })
  end

  # POST /signup
  def create
    @user = User.create(user_params)
    if @user.save
      auth_token = AuthenticateUser.new(@user.username, @user.password).call
      response   = {
        message:    Message.account_created,
        auth_token: auth_token,
        user:       @user.attributes.except("password_digest", "auth_token")
      }
      json_response(response, :created)
    else
      errors_for(@user)
    end
  end

  private

  def user_params
    params.permit(
      :username,
      :password
    )
  end

  def errors_for(user)
    @payload = {
      user:    user,
      errors:  user.errors
    }
    json_response(@payload, :unprocessable_entity)
  end
end

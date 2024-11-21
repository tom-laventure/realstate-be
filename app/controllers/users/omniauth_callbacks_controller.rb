class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include RackSessionsFix
  skip_before_action :verify_authenticity_token, only: :facebook

  def facebook
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      sign_in user
      render json: { message: "Logged in successfully", user: user }, status: :ok
    else
      render json: { error: "Authentication failed" }, status: :unauthorized
    end
  end

  def failure
    render json: { error: "Facebook authentication failed" }, status: :unauthorized
  end
end
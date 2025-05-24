class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create user ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  before_action :redirect_if_signed_in, only: %i[ new create ]

  def new
  end

  def create
    @user = user_exists? ? User.authenticate_by(login_params) : User.create(signup_params)

    if @user.present? && @user.errors.none?
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "Login Success"
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, notice: "Logout Success"
  end

  def user
    head (user_exists? ? :ok : :not_found)
  end

  private

  def login_params
    params.permit(:email_address, :password)
  end

  def signup_params
    params.permit(:email_address, :password, :password_confirmation)
  end

  def user_exists?
    User.exists?(email_address: params[:email_address])
  end

  def redirect_if_signed_in
    redirect_to after_authentication_url, notice: "You're already logged in" if authenticated?
  end
end

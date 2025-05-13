class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    user = if user_exists?
      User.authenticate_by(login_params)
    else
      User.create!(signup_params)
    end

    if user.present?
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Login Success"
    else
      redirect_to new_session_path, alert: "Login Failed: Try another email address or password."
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("flash", %(<div style="color: red">#{e.message}</div>).html_safe)
      end
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, notice: "Logout Success"
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
end

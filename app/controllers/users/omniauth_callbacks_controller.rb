# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # Facebook OAuth callback
  def facebook
    handle_oauth("Facebook")
  end

  # Google OAuth callback
  def google_oauth2
    handle_oauth("Google")
  end

  # Handle failures
  def failure
    redirect_to root_path, alert: "Authentication failed. Please try again."
  end

  private

  def handle_oauth(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    else
      session["devise.#{provider.downcase}_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end
end

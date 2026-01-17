class SettingsController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
  end

  def update
    @user = current_user
    
    if @user.update(user_params)
      redirect_to settings_path, notice: "Settings updated successfully."
    else
      render :profile, status: :unprocessable_entity
    end
  end

  def destroy_account
    current_user.destroy
    redirect_to root_path, notice: "Your account has been deleted. We're sorry to see you go!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :email_notifications, :theme)
  end
end

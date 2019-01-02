class PreferencesController < ApplicationController

  def index
    redirect_to '/' unless current_user
  end

  def update
    update_user
    if current_user.notifications
      flash[:notice] = "You are signed up for daily text notifications"
    else
      flash[:notice] = "You are no longer signed up for daily text notifications"
    end
    redirect_to dashboard_path
  end

private

  def update_user
    update = !current_user.notifications
    current_user.update(notifications: update)
  end
end

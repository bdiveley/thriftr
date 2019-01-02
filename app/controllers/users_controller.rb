class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      twilio_verify(current_user.phone_number)
      redirect_to register_path
    else
      flash[:error] = "Please complete all fields and enter a unique and valid phone number"
      redirect_to new_user_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    if code_verified
      current_user.update(phone_number: session[:new_phone_number])
      flash[:success] = "Phone number successfully updated"
      redirect_to dashboard_path
    else
      flash[:error] = "Verification code was incorrect. Phone number was not updated. Try again!"
      redirect_to edit_user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :phone_number)
  end

end

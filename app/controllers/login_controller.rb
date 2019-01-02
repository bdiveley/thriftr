class LoginController < ApplicationController

  def new
   if user = User.find_by(phone_number: params[:q])
     session[:user_id] = user.id
     twilio_verify(current_user.phone_number)
     redirect_to '/ynab'
   else
     flash[:error] = "We don't have that number in our system, please try again"
     redirect_to root_path
   end
  end

  def create
   if code_verified
     redirect_to dashboard_path
   else
     session.clear
     flash[:error] = "Verification code was incorrect. Please login again"
     redirect_to root_path
   end
  end

  def destroy
   session.clear
   flash[:message] = "You successfully logged out"
   redirect_to root_path
  end
end

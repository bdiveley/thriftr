class LoginController < ApplicationController

 def new
   if user = User.find_by(phone_number: params[:q])
     session[:user_id] = user.id
     twilio_verify
     redirect_to '/ynab'
   else
     flash[:error] = "Try again!"
     redirect_to root_path
   end
 end

 def create
   if params[:q] == session[:code]
     redirect_to dashboard_path
   else
     session.clear
     flash[:error] = "Verification code was incorrect. Please login again"
     redirect_to root_path
   end
 end
end
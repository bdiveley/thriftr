class ApplicationController < ActionController::Base

  helper_method :current_user, :random_code

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def random_code
    rand(10000..99999).to_s
  end

  def twilio_verify(phone_number)
    session[:code] = random_code
    TwilioService.new.send_verification_code(phone_number,session[:code])
  end

  def code_verified
    params[:q] == session[:code]
  end

end

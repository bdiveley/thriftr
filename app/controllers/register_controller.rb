class RegisterController < ApplicationController

  def index
    if auth_hash
      session[:token] = auth_hash["credentials"]["token"]
      update_budget_id
      @direction = :login
    else
      @direction = :register
    end
  end

  def create
    if code_verified
      verify_user
      flash[:error] = "Please login to complete the registration process"
      redirect_to root_path
    else
      clear_user
      flash[:error] = "Verification code was incorrect. Please re-enter information"
      redirect_to new_user_path
    end
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end

  def get_id(token)
    service = YnabService.new({token: token})
    service.return_budget_id
  end

  def clear_user
    User.find(session[:user_id]).delete
    session.clear
  end

  def verify_user
    current_user.update(verified: true)
    session.clear
  end

  def budget_id
    get_id(session[:token])
  end

  def update_budget_id
    unless current_user.ynab_budget_id
      current_user.update(ynab_budget_id: budget_id)
    end
  end
end

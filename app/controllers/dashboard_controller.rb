class DashboardController < ApplicationController

  def index
    if budget_params
      @facade = BudgetFacade.new({name: params[:name], types: params[:types]})
    end
    redirect_to '/' unless current_user
  end

private

  def budget_params
    params[:name] && params[:types]
  end
end

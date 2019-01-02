class BudgetFacade

  def initialize(data)
    @name = data[:name]
    @types = data[:types]
    @budget_categories = {"bar" => ["Bars", "Dining Out", "Drinks"],
                          "restaurant" => ["Restaurants", "Eating Out", "Dining", "Dining Out"],
                          "store" => ["Clothing", "Gifts"],
                          "bowling_alley" => ["Entertainment", "Bowling", "For Fun"]}
  end

  def location_name
    @name
  end

  def location_budgets(data)
    budgets = []
    @types.each do |type|
      @budget_categories[type].each do |name|
        request_budgets(data).each do |budget|
          budgets << budget if budget.name == name
        end
      end
    end
    budgets.uniq
  end

  def request_budgets(data)
    budgets(data).map do |budget|
      Budget.new(budget[:name],
                budget[:balance])
    end
  end

private
  def service(data)
    YnabService.new(data)
  end

  def budgets(data)
    service(data).budget_categories
  end

end

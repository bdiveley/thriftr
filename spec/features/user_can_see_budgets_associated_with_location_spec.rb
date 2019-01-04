require 'rails_helper'

describe 'a user' do
  describe 'selects a location from nearby locations' do
    it 'displays related budgets', :js do
      stub_nearby_search
      stub_full_budget_data

      # As a registered user
      user = User.create(username: "godzilla", phone_number: ENV['REGISTERED_NUMBER'], ynab_budget_id: "#{ENV['YNAB_BUDGET_ID']}")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # From the /results page
      visit '/results?location=39.742905,-104.989545'
      # I click on the link of a Location Name
      click_link "Maggiano's Little Italy"
      # I am redirected to /dashboard
      expect(current_path).to eq('/dashboard')
      # And a message is displayed that tells me the amount of money remaining in my budget that falls under the category of the selected location.
      expect(page).to have_content("You have $150.00 left in your Dining Out budget")
      # My ynab_user_id is saved in the db the first time this happens

      visit '/results?location=39.742905,-104.989545'
      click_link "Lucky Strike Denver"
      # I am redirected to /dashboard
      expect(current_path).to eq('/dashboard')
      # And a message is displayed that tells me the amount of money remaining in my budget that falls under the category of the selected location.
      expect(page).to have_content("You have $150.00 left in your Dining Out budget")
      expect(page).to have_content("You have $115.25 left in your Entertainment budget")
    end
  end

end

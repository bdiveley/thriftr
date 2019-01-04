require 'rails_helper'

describe 'a user' do
  it 'can search nearby for current location', :js do
    stub_nearby_search

    # As a registered user
    user = User.create(username: "godzilla", phone_number: ENV['REGISTERED_NUMBER'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # When I visit /dashboard
    visit '/dashboard'
    # Then I see a button that says “Search Current Location”
    # And when I click on the button “Search Current Location”
    click_on 'Search Current Location'
    # I am redirected to /results
    visit '/results?location=39.742905,-104.989545'
    #### Because we cannot stub the return of the javascript, we'll visit the page with the query param instead
    expect(current_path).to eq(results_path)
    # Under a section called Select Your Current Location”
    expect(page).to have_content("Select Your Current Location")
    # I see a list of links with Location Names within 100 meters of my current location
    within '.locations' do
      expect(page).to have_css(".location", count: 6)
      expect(page).to have_link("Maggiano's Little Italy")
    end
  end

  it 'gets an error message if no places are nearby', :js do
    stub_nearby_search_sad

    user = User.create(username: "godzilla", phone_number: ENV['REGISTERED_NUMBER'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    #### Because we cannot stub the return of the javascript, we'll visit the page with the query param instead
    click_on 'Search Current Location'

    visit '/results?location=39.563941,-104.616441'
    expect(current_path).to eq(results_path)

    expect(page).to have_content("No Locations Detected Nearby")
  end

end

require 'rails_helper'

feature "as a registered user" do
  scenario "I can toggle daily notifications", :js do
    user = User.create(username: "godzilla", phone_number: ENV['REGISTERED_NUMBER'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit preferences_path

    expect(page).to have_content("Would You Like to Change Your Daily Notification Preference?")

    click_on "Yes!"

    expect(user.notifications).to eq(false)
    expect(page).to have_content("You are no longer signed up for daily text notifications")

    visit preferences_path

    click_on "Yes!"

    expect(user.notifications).to eq(true)
    expect(page).to have_content("You are signed up for daily text notifications")

  end
end

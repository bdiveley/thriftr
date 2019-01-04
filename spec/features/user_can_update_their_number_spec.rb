require 'rails_helper'

feature "as a registered user" do
  scenario "I can update my phone number", :js do
    VCR.use_cassette("user_updates_phone_number_cassette") do
      user = User.create(username: "godzilla", phone_number: "3038853559")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      expect(page).to have_content(user.phone_number)

      click_on ("Update My Phone Number")

      expect(current_path).to eq(edit_user_path(user))
      expect(page).to have_content("Please enter new phone number below")
      fill_in 'user[phone_number]', with: ENV['REGISTERED_NUMBER']

      click_on ("Update Phone Number")

      expect(current_path).to eq(edit_verification_path(user))

      fill_in :q, with: 12345
      click_on "Verify"

      expect(page).to have_content("Verification code was incorrect. Phone number was not updated. Try again!")
      expect(current_path).to eq(edit_user_path(user))
    end
  end
end

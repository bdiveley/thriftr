# Thriftr - https://fierce-cove-88613.herokuapp.com/

Thriftr is meant be used in conjunction with an existing budgeting app called YNAB (You Need a Budget).  YNAB’s role is to link the user’s bank/credit accounts with their budget based on established spending categories.  Since Thriftr is connecting with an app that  holds many private financial account information for their users, Thrifter utilizes a two-step login and authentication process each time the user logs in.  The first step is via the YNAB OmniAuth Gem and the second step is through a 5-digit randomized code sent to the user's submitted phone number.  The user must submit their YNAB user name and password along with the correct cell phone code in order to get login access.

Once a user is logged in to Thriftr, the app utilizes YNAB’s API to notify the user of their remaining budget on a per-category basis.  When a user is entering a restaurant, for example, they can use Thriftr to get a quick snapshot of their remaining budget for their “Out to Eat” budget category which utilizes the Google Nearby Search API. In addition, Thriftr is meant to be a mobile budgeting coach.  The user can opt-in to receive daily notifications about their budget and supportive 'coaching' texts to keep them on track with their budgeting goals.  Daily Notifications are provided via the Twilio API and Heroku Scheduler.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

From GitHub clone down repository using the following commands in terminal:
* git git@github.com:ryan-mcneil/thriftr.git
* cd thriftr

### Prerequisites

Thriftr was developed in Rails 5.2 and so we recommend using the same or a more current version of Rails.  The Ruby version used is 2.4

To check your version using terminal run: rails -v in the command line. (use ruby -v to retrieve the ruby version)

If you have not installed rails, in terminal run: gem install rails -v 5.1 in the command line.

### Installing

Open terminal and run these commands:
* bundle
* rake db:{drop,create,migrate,seed}
* rails s (this will open the server to look at the program in development)

* To fully utilize and test the development environment, you must login and create an NGROK account in order to create a secure website for development (https://ngrok.com/)

* Open up a web browser (preferably Chrome)

* Navigate to localhost:3000 or the provided ngrok secure website in order to gain access to the Thriftr landing page.  Once on the landing page, follow the instructions to create a YNAB account, Thriftr Account or Login if you have already registered for both.

### API_KEYS
In order to full utilize the functionality of this app, you must create accounts for and sign up to receive a number of API Keys.

*Google_API - https://developers.google.com/places/web-service/get-api-key
*Twilio_API - https://www.twilio.com/try-twilio
*YNAB_API - https://api.youneedabudget.com/

Once you receive each of these keys, follow these steps to add them to your Thriftr application:

From the terminal run - figaro install
This will create a hidden file in config/application.yml
Within this hidden file, add your new API keys using the following format:
YNAB_API_KEY: ynab_api_key_goes_here
YNAB_CLIENT_ID: ynab_client_id_here
YNAB_CLIENT_SECRET: ynab_client_secret_here
GOOGLE_API_KEY: google_api_key_goes_here
TWILIO_ACCOUNT_SID: twilio_account_sid_here
TWILIO_AUTH_TOKEN: twilio_auth_token_here
REGISTERED_NUMBER: registered_twilio_phone_number

## Running the tests

* Note: Before running RSpec, ensure you're in the project root directory.

From the terminal run: rspec

After RSpec has completed, you should see all tests passing as GREEN.  Any tests that have failed or thrown an error will display RED.  Any tests that have been skipped will be displayed as YELLOW.

## Built With

* Rails
* YNAB Omniauth
* YNAB API
* Twillio API
* Google API
* RSpec
* ShouldaMatchers
* Capybara
* Launchy
* Pry
* SimpleCov
* FactoryBot
* BCrypt
* PostreSQL

## Authors

* Bailey Diveley - Github: BDiveley
* Ryan McNeil - Github: ryan-mcneil
* Quinn Krug - Github: Q-Win

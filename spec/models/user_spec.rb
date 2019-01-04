require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :phone_number }
    it { should validate_uniqueness_of :phone_number }
    it { should validate_presence_of :username }
  end
  describe 'class methods' do
    it '::daily_notification_users'do
    user_1 = User.create(username: "a", phone_number: ENV['REGISTERED_NUMBER'])
    user_2 = User.create(username: "b", phone_number: ENV['REGISTERED_NUMBER'], notifications: false)

    users = User.daily_notification_users

    expect(users.count).to eq(1)
    end
  end
end

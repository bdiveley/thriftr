require 'rails_helper'

RSpec.describe TwilioService do

  it 'it exists' do
    service = TwilioService.new

    expect(service).to be_a(TwilioService)
  end

  it '.formatted_number' do
    number = 1234567891
    service = TwilioService.new

    expect(service.formatted_number(number)).to eq("+11234567891")
  end

  it 'can send_verification_code' do
    VCR.use_cassette("twilio_verify_cassette") do
      number = ENV['REGISTERED_NUMBER']
      code = "43819"
      service = TwilioService.new
      response = service.send_verification_code(number,code)

      expect(response.body).to eq("Sent from your Twilio trial account - #{code}")
    end
  end
  it 'can send_verification_code' do
    VCR.use_cassette("twilio_notification_cassette") do
      number = ENV['REGISTERED_NUMBER']
      msg = Message.create(text_msg: "Have you checked your YNAB budget today?")
      service = TwilioService.new
      response = service.send_notification(number, msg)

      expect(response.body).to eq("Sent from your Twilio trial account - Have you checked your YNAB budget today?")
    end
  end
end

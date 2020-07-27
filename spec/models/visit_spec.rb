# spec/models/user_spec.rb
require 'rails_helper'
require 'faker'
require 'factory_bot_rails'
require 'knock'

RSpec.describe Visit, :type => :model do
  subject {
   described_class.new(date: "2020-08-26 08:00:00.202929584 -0300",
                       checkin_at: "2020-02-26 12:00:00",
                       checkout_at: "2020-02-26 14:00:00",
                       user_id: 2,
                       status: "Realizado"
                      )
  }

  it "is valid with valid attributes" do
    @user = FactoryBot.create(:user)
    expect(subject).to be_valid
  end

  it "is not valid without a valid user_id" do
    subject.user_id = 1
    expect(subject).to_not be_valid
  end

  it "is not valid with date less than date of creation" do
    subject.date = "2010-02-26 08:00:00.202929584 -0300"
    expect(subject).to_not be_valid
  end
  it "is not valid with checkin_at greater than or equal to today" do
    subject.checkin_at = "2020-07-27 08:00:00.202929584 -0300"
    expect(subject).to_not be_valid
  end
  it "is not valid with checkin_at greater than checkout_at" do
    subject.checkin_at = "2020-07-27 08:00:00.202929584 -0300"
    expect(subject).to_not be_valid
  end
end

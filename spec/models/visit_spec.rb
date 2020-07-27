# spec/models/user_spec.rb
require 'rails_helper'
require 'faker'
require 'factory_bot_rails'
require 'knock'

FactoryBot.define do
  factory :user do
    id { 2 }
    email { 'mirtha_reilly@little-kerluke.co' }
    cpf  {'04985100420'}
    password {'poliglota90'}
    name { "Test user" }
  end
end

RSpec.describe Visit, :type => :model do
  before(:all) do
    @user = FactoryBot.create(:user)
  end

  subject {
   described_class.new(date: "2020-08-26 08:00:00.202929584 -0300",
                       checkin_at: "2020-02-26 12:00:00",
                       checkout_at: "2020-02-26 14:00:00",
                       user_id: @user.id,
                       status: "Realizado"
                      )
  }

  it "is valid with valid attributes" do
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

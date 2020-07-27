# spec/models/user_spec.rb
require 'rails_helper'
require 'faker'
require 'factory_bot_rails'
require 'knock'

RSpec.describe User, :type => :model do
  subject {
   described_class.new(email: Faker::Internet.email,
                       cpf: Faker::IDNumber.brazilian_citizen_number,
                       password: Faker::Alphanumeric.alphanumeric(number: 8)
                      )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a password with diversify numbers and letters" do
    subject.password = 'awlksss'
    expect(subject).to_not be_valid
  end
  it "is not valid without a password greater than 6 digits" do
    subject.password = Faker::Alphanumeric.alphanumeric(number: 5)
    expect(subject).to_not be_valid
  end
  it "is not valid without a valid cpf" do
    subject.cpf = Faker::IDNumber.south_african_id_number
    expect(subject).to_not be_valid
  end
  it "is not valid without a unique cpf" do
    user1 = FactoryBot.create(:user)
    user1.save
    user2 = FactoryBot.build(:user)
    expect(user2).to_not be_valid
  end
  it "is not valid without a unique email" do
    user1 = FactoryBot.create(:user)
    user1.save
    user2 = FactoryBot.build(:user)
    expect(user2).to_not be_valid
  end
end

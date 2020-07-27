require 'rails_helper'
require 'factory_bot_rails'

FactoryBot.define do
  factory :formulary do
    name { "Test formulary 1" }
  end
end

RSpec.describe Formulary, :type => :model do
  subject {
   described_class.new(name: 'Test Formulary 2')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a unique name" do
    formulary1 = FactoryBot.create(:formulary)
    formulary1.save
    formulary2 = FactoryBot.build(:formulary)
    expect(formulary2).to_not be_valid
  end
end

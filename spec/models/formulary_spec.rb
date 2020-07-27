require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe Formulary, :type => :model do
  subject {
   described_class.new(name: 'Test Formulary 2')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a unique name" do
    formulary1 =  FactoryBot.create(:formulary)
    formulary2 = FactoryBot.build(:formulary)
    expect(formulary2).to_not be_valid
  end
end

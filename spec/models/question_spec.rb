require 'rails_helper'
require 'factory_bot_rails'

FactoryBot.define do
  factory :formulary do
    id { 1 }
    name { "Test formulary 1" }
  end
end

FactoryBot.define do
  factory :question do
    name { "Test 1" }
    formulary_id { 1 }
    question_type {'hohoihdoihd'}
  end
end

RSpec.describe Question, :type => :model do
  before(:all) do
    @formulary = FactoryBot.create(:formulary)
  end

  subject {
   described_class.new(name: 'Question test 2',
                       formulary_id: 1,
                       question_type: 'hohoihdoihd'
                     )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a unique name in the form" do
    question1 = FactoryBot.create(:question)
    question1.save
    question2 = FactoryBot.build(:question)
    expect(question2).to_not be_valid
  end
end

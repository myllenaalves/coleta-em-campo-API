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

RSpec.describe Answer, :type => :model do
  before(:all) do
    @formulary = FactoryBot.create(:formulary)
    @question = FactoryBot.create(:question)
  end

  subject {
   described_class.new(content: 'iehoiehioh',
                       formulary_id: 1,
                       question_id: 1,
                       visit_id: 1
                     )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a valid formulary_id" do
    subject.formulary_id = 3
    expect(subject).to_not be_valid
  end

  it "is not valid without a valid question_id" do
    subject.question_id = 3
    expect(subject).to_not be_valid
  end
end

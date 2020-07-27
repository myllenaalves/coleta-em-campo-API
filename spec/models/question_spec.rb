require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe Question, :type => :model do
  subject {
   described_class.new(name: 'Question test 2',
                       formulary_id: 2,
                       question_type: 'hohoihdoihd'
                     )
  }

  it "is valid with valid attributes" do
    @formulary = FactoryBot.create(:formulary)
    expect(subject).to be_valid
  end

  it "is not valid without a unique name in the form" do
    question2 = FactoryBot.build(:question)
    expect(question2).to_not be_valid
  end
end

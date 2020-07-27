require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe Answer, :type => :model do
  subject {
   described_class.new(content: 'iehoiehioh',
                       formulary_id: 2,
                       question_id: 2,
                       visit_id: 2
                     )
  }

  it "is valid with valid attributes" do
    @formulary = FactoryBot.create(:formulary)
    @question = FactoryBot.create(:question)
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

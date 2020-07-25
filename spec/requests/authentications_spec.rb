require 'rails_helper'

FactoryBot.define do
  factory :user do
    email { 'columbus_bahringer@robel-bednar.io' }
    cpf  {'01070681504'}
    password {'poliglota90'}
  end
end

RSpec.describe "Authenticate", type: :request do
  describe "GET /authenticate" do
    it 'when authentication is not valid' do
      post '/api/v1/authenticate'
      expect(response).to have_http_status(:unauthorized)
    end

    it "when authentication is valid" do
      user = FactoryBot.create(:user)
      post '/api/v1/authenticate', params:{email: user.email, password: user.password}
      expect(response).to have_http_status(200)
    end
  end
end

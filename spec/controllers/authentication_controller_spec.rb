require 'rails_helper'
require 'factory_bot_rails'

FactoryBot.define do
  factory :user do
    email { 'columbus_bahringer@robel-bednar.io' }
    cpf  {'01070681504'}
    password {'poliglota90'}
  end
end

RSpec.describe Api::V1::AuthenticationController, :type => :controller do
  describe 'GET /api/v1/user' do

    context 'when the request with NO authentication header' do
      it 'should return unauth for retrieve current user info before login' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the request contains an authentication header' do
      it 'should return the user info' do
        user = FactoryBot.create(:user)
        post :authenticate, params:{email: user.email, password: user.password}
        expect(response.body).to include("auth_token")
      end
    end
  end
end

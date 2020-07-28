require 'rails_helper'

RSpec.describe "Authenticate", type: :request do
  describe "GET /authenticate" do
    it 'when authentication is not valid' do
      post '/api/v1/authenticate', params:{email: 'blablabla@gmail.com', password: 'hhihiuhiuh198908'}
      expect(response).to have_http_status(:unauthorized)
    end

    it "when authentication is valid" do
      user = FactoryBot.create(:user)
      post '/api/v1/authenticate', params:{email: user.email, password: user.password}
      expect(response).to have_http_status(200)
    end
  end
end

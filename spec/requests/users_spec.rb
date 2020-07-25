require 'rails_helper'

FactoryBot.define do
  factory :user do
    email { 'columbus_bahringer@robel-bednar.io' }
    cpf  {'01070681504'}
    password {'poliglota90'}
  end
end

RSpec.describe "Users", type: :request do
  describe "users#index" do
    it "should request a list of users" do
      get "/api/v1/user"
      expect(response).to be_successful
      expect(response.body).to include(:user)
    end

    it "when the user isn't authenticated" do
    end

    it "when the users are loaded" do
      get '/api/v1/user'
      expect(response).to have_http_status(200)
    end

    it "when the users aren't loaded" do
      get '/api/v1/user'
      expect(response).to have_http_status(401)
    end

    it "responds to custom formats when provided in the params" do
    end
  end

  describe "users#post" do
    it 'create user with valid attributes' do
      user = FactoryBot.create(:user)
      post '/api/v1/user', :params => :user.to_json, :headers => { "Content-Type": "application/json" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(201)
    end
  end
end

require 'rails_helper'
require 'faker'
require 'factory_bot_rails'


FactoryBot.define do
  factory :user do
    email { 'columbus_bahringer@robel-bednar.io' }
    cpf  {'01070681504'}
    password {'poliglota90'}
  end
end

RSpec.describe "Users", :type => :request do
  describe "GET users#index" do
    it "should request a list of users" do
      user = FactoryBot.create(:user)
      get "api/v1/user", :params => { :user => :user }
      expect(response).to be_successful
      expect(response.body).to include(“Test user”)
    end

    it "should return a unauthorized message" do
    end

    it "has a 200 status code" do
      get '/api/v1/users'
      expect(response).to have_http_status(200)
    end

    it "has a 401 status code" do
    end

    it "responds to custom formats when provided in the params" do
    end
  end

  describe "POST create" do
    it 'responds with a valid JWT' do
    end

    it "should create a user" do
    end

    it "has a 200 status code" do
    end

    it "has a 401 status code" do
    end

    it "responds to custom formats when provided in the params" do
    end

  end

  describe "PUT update" do
    it "should update a user" do
    end

    it "has a 200 status code" do
    end

    it "has a 401 status code" do
    end

    it "responds to custom formats when provided in the params" do
    end

  end

  describe "DELETE destroy" do
    it "should delete a user" do
    end

    it "has a 200 status code" do
    end

    it "has a 401 status code" do
    end

    it "responds to custom formats when provided in the params" do
    end
  end
end

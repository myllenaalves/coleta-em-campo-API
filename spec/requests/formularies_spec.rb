require 'rails_helper'

FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'columbus_bahringer@robel-bednar.io' }
    cpf  {'01070681504'}
    password {'poliglota90'}
    name { "Test user" }
  end
end

FactoryBot.define do
  factory :formulary do
    id { 2 }
    name { "Test formulary 1" }
  end
end

RSpec.describe "Formularies", type: :request do
  before(:all) do
    @user = FactoryBot.create(:user)
    @formulary = FactoryBot.create(:formulary)
  end

  describe "formularies#index" do
    it "should request a list of formularies" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      get "/api/v1/formulary"
      expect(response).to be_successful
      expect(response.body).to include("Formulários carregados")
      expect(response).to have_http_status(200)
    end

    it "when the user isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      get "/api/v1/formulary"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "formularies#post" do
    it 'when the formulary is created' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      post '/api/v1/formulary', params: {:name => 'Test formulary 2'}
      expect(response).to have_http_status(201)
      expect(response.body).to include("Formulário foi criado")
    end

    it "when the user isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      post "/api/v1/formulary", params: {:name => 'Test formulary 2'}
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "formularies#put" do
    it 'when the formulary is updated' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      put '/api/v1/formulary/2', params: {:name => 'Test formulary'}
      @formulary.reload
      expect(response).to have_http_status(200)
      expect(response.body).to include("Formulário foi editado")
    end

    it 'when the formulary is not found' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      put '/api/v1/formulary/3', params: {:name => 'Test formulary'}
      expect(response).to have_http_status(422)
      expect(response.body).to include("Formulário não foi encontrado")
    end

    it "when the formulary isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      put "/api/v1/formulary/2"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "formularies#delete" do
    it 'when the formulary is deleted' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      delete '/api/v1/formulary/2'
      expect(response).to have_http_status(200)
      expect(response.body).to include("Formulário foi deletado")
    end

    it 'when the formulary is not found' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      delete '/api/v1/formulary/3'
      expect(response).to have_http_status(422)
      expect(response.body).to include("Formulário não foi encontrado")
    end

    it "when the formulary isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      delete "/api/v1/formulary/2"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end
end

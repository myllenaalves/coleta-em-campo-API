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
  factory :question do
    id { 2 }
    name {'lkdhkldah'}
    formulary_id { 1 }
    question_type {'ifahoifh'}
  end
end

FactoryBot.define do
  factory :formulary do
    id { 1 }
    name { "Test formulary 1" }
  end
end

RSpec.describe "Questions", type: :request do
  before(:all) do
    @user = FactoryBot.create(:user)
    @formulary = FactoryBot.create(:formulary)
    @question = FactoryBot.create(:question)
  end

  describe "questions#index" do
    it "should request a list of questions" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      get "/api/v1/question"
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "when the user isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      get "/api/v1/question"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "questions#post" do
    it 'when the question is created' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      post '/api/v1/question', params: {:name => 'Test question 2', formulary_id: 1, question_type: 'fknlkfnklnf'}
      expect(response).to have_http_status(201)
    end

    it "when the user isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      post "/api/v1/question"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "questions#put" do
    it 'when the question is updated' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      put '/api/v1/question/2', params: {:name => 'Test question'}
      @question.reload
      expect(response).to have_http_status(200)
      expect(response.body).to include("Pergunta foi editada")
    end

    it 'when the question is not found' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      put '/api/v1/question/3'
      expect(response).to have_http_status(422)
      expect(response.body).to include("Pergunta não foi encontrada")
    end

    it "when the question isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      put "/api/v1/question/2"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "questions#delete" do
    it 'when the question is deleted' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      delete '/api/v1/question/2'
      expect(response).to have_http_status(200)
      expect(response.body).to include("Pergunta foi deletada")
    end

    it 'when the question is not found' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      delete '/api/v1/question/3'
      expect(response).to have_http_status(422)
      expect(response.body).to include("Pergunta não foi encontrada")
    end

    it "when the question isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      delete "/api/v1/question/2"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end
end

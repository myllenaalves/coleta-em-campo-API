require 'rails_helper'

RSpec.describe "Answers", type: :request do
  before(:all) do
    @user = FactoryBot.build(:user)
  end
  describe "answers#index" do
    it "should request a list of answers" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      get "/api/v1/answer"
      expect(response.body).to include("Respostas carregadas")
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "when the user isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      get "/api/v1/answer"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "answers#post" do
    it 'when the answer is created' do
      @formulary = FactoryBot.create(:formulary)
      @question = FactoryBot.create(:question)
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      post '/api/v1/answer', params: {:content => 'fhohfohfo', :question_id => 2, :formulary_id => 2, :visit_id => 2}
      expect(response).to have_http_status(201)
    end

    it "when the user isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      post "/api/v1/answer"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "answers#put" do
    it 'when the answer is updated' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      @formulary = FactoryBot.create(:formulary)
      @question = FactoryBot.create(:question)
      @answer = FactoryBot.create(:answer)
      put '/api/v1/answer/2', params: {:content => 'knlknk'}
      @answer.reload
      expect(response).to have_http_status(200)
      expect(response.body).to include("Resposta foi editada")
    end

    it 'when the answer is not found' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      put '/api/v1/answer/3'
      expect(response).to have_http_status(422)
      expect(response.body).to include("Resposta não foi encontrada")
    end

    it "when the answer isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      put "/api/v1/answer/2"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "answers#delete" do
    it 'when the answer is deleted' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      @formulary = FactoryBot.create(:formulary)
      @question = FactoryBot.create(:question)
      @answer = FactoryBot.create(:answer)
      delete '/api/v1/answer/2'
      expect(response).to have_http_status(200)
      expect(response.body).to include("Resposta foi deletada")
    end

    it 'when the answer is not found' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      delete '/api/v1/answer/3'
      expect(response).to have_http_status(422)
      expect(response.body).to include("Resposta não foi encontrada")
    end

    it "when the answer isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      delete "/api/v1/answer/2"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end
end

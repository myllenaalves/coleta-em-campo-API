require 'rails_helper'

RSpec.describe "Questions", type: :request do
  before(:all) do
    @user = FactoryBot.build(:user)
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
      post '/api/v1/question', params: {:name => 'Test question 2', formulary_id: 2, question_type: 'fknlkfnklnf'}
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

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
    id { 1 }
    name {'Test question 1'}
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

FactoryBot.define do
  factory :visit do
    id { 1 }
    date { '2020-08-26 11:59:02.202929584 -0300' }
    checkin_at { '2020-05-26 12:59:02.202929584 -0300' }
    checkout_at  {'2020-08-26 15:59:02.202929584 -0300'}
    status {'Realizado'}
    user_id { 1 }
  end
end

FactoryBot.define do
  factory :answer do
    id { 2 }
    content { "Test answer 1" }
    question_id { 1 }
    formulary_id { 1 }
    visit_id { 1 }
  end
end

RSpec.describe "Answers", type: :request do

  before(:all) do
    @user = FactoryBot.create(:user)
    @formulary = FactoryBot.create(:formulary)
    @question = FactoryBot.create(:question)
    @visit = FactoryBot.create(:visit)
    @answer = FactoryBot.create(:answer)
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
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      post '/api/v1/answer', params: {:content => 'fhohfohfo', :question_id => 1, :formulary_id => 1, :visit_id => 1}
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
      put '/api/v1/answer/2', params: {:content => 'knlknk', :question_id => 1, :formulary_id => 1, :visit_id => 1}
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

require 'rails_helper'

RSpec.describe "Questions", type: :request do
  before(:all) do
    @user = FactoryBot.build(:user)
    @question = FactoryBot.create(:question)
  end

  describe "questions#index" do
    it "should request a list of questions" do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      get "/api/v1/question", headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "when the user isn't authenticated" do
      get "/api/v1/question"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "questions#post" do
    it 'when the question is created' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      post '/api/v1/question', params: {:name => 'Test question 2', formulary_id: 2, question_type: 'fknlkfnklnf'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(201)
    end

    it "when the user isn't authenticated" do
      post "/api/v1/question"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "questions#put" do
    it 'when the question is updated' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      put '/api/v1/question/2', params: {:name => 'Test question'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
      @question.reload
      expect(response).to have_http_status(200)
      expect(response.body).to include("Pergunta foi editada")
    end

    it 'when the question is not found' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      put '/api/v1/question/3',  headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(422)
      expect(response.body).to include("Pergunta não foi encontrada")
    end

    it "when the question isn't authenticated" do
      put "/api/v1/question/2"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "questions#delete" do
    it 'when the question is deleted' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      delete '/api/v1/question/2', headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(200)
      expect(response.body).to include("Pergunta foi deletada")
    end

    it 'when the question is not found' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      delete '/api/v1/question/3', headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(422)
      expect(response.body).to include("Pergunta não foi encontrada")
    end

    it "when the question isn't authenticated" do
      delete "/api/v1/question/2"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end
end

require 'rails_helper'

RSpec.describe "Answers", type: :request do
  before(:all) do
    @user = FactoryBot.build(:user)
  end
  describe "answers#index" do
    it "should request a list of answers" do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      get "/api/v1/answer", headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response.body).to include("Respostas carregadas")
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "when the user isn't authenticated" do
      get "/api/v1/answer"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "answers#post" do
    it 'when the answer is created' do
      @user = FactoryBot.create(:user)
      @formulary = FactoryBot.create(:formulary)
      @question = FactoryBot.create(:question)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      post '/api/v1/answer', params: {:content => 'fhohfohfo', :question_id => 2, :formulary_id => 2, :visit_id => 2}, headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(201)
    end

    it "when the user isn't authenticated" do
      post "/api/v1/answer"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "answers#put" do
    it 'when the answer is updated' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      @formulary = FactoryBot.create(:formulary)
      @question = FactoryBot.create(:question)
      @answer = FactoryBot.create(:answer)
      put '/api/v1/answer/2', params: {:content => 'knlknk'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
      @answer.reload
      expect(response).to have_http_status(200)
      expect(response.body).to include("Resposta foi editada")
    end

    it 'when the answer is not found' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      put '/api/v1/answer/3', headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(422)
      expect(response.body).to include("Resposta não foi encontrada")
    end

    it "when the answer isn't authenticated" do
      put "/api/v1/answer/2"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "answers#delete" do
    it 'when the answer is deleted' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      @formulary = FactoryBot.create(:formulary)
      @question = FactoryBot.create(:question)
      @answer = FactoryBot.create(:answer)
      delete '/api/v1/answer/2', headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(200)
      expect(response.body).to include("Resposta foi deletada")
    end

    it 'when the answer is not found' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      delete '/api/v1/answer/3', headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(422)
      expect(response.body).to include("Resposta não foi encontrada")
    end

    it "when the answer isn't authenticated" do
      delete "/api/v1/answer/2"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end
end

require 'rails_helper'

RSpec.describe "Formularies", type: :request do
  before(:all) do
    @user = FactoryBot.build(:user)
    @formulary = FactoryBot.create(:formulary)
  end

  describe "formularies#index" do
    it "should request a list of formularies" do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      get "/api/v1/formulary", headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to be_successful
      expect(response.body).to include("Formulários carregados")
      expect(response).to have_http_status(200)
    end

    it "when the user isn't authenticated" do
      get "/api/v1/formulary"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "formularies#post" do
    it 'when the formulary is created' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      post '/api/v1/formulary', params: {:name => 'Test formulary 2'},  headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(201)
      expect(response.body).to include("Formulário foi criado")
    end

    it "when the user isn't authenticated" do
      post "/api/v1/formulary", params: {:name => 'Test formulary 2'}
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "formularies#put" do
    it 'when the formulary is updated' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      put '/api/v1/formulary/2', params: {:name => 'Test formulary'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
      @formulary.reload
      expect(response).to have_http_status(200)
      expect(response.body).to include("Formulário foi editado")
    end

    it 'when the formulary is not found' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      put '/api/v1/formulary/3', params: {:name => 'Test formulary'},  headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(422)
      expect(response.body).to include("Formulário não foi encontrado")
    end

    it "when the formulary isn't authenticated" do
      put "/api/v1/formulary/2"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "formularies#delete" do
    it 'when the formulary is deleted' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      delete '/api/v1/formulary/2', headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(200)
      expect(response.body).to include("Formulário foi deletado")
    end

    it 'when the formulary is not found' do
      @user = FactoryBot.create(:user)
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      delete '/api/v1/formulary/3', headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(422)
      expect(response.body).to include("Formulário não foi encontrado")
    end

    it "when the formulary isn't authenticated" do
      delete "/api/v1/formulary/2"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end
end

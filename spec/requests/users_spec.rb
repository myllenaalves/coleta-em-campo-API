require 'rails_helper'

RSpec.describe "Users", type: :request do
  before(:all) do
    @user = FactoryBot.create(:user)
  end

  describe "users#index" do
    it "should request a list of users" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      get "/api/v1/user"
      expect(response).to be_successful
      expect(response.body).to include("Usuários carregados")
      expect(response).to have_http_status(200)
    end

    it "when the user isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      get "/api/v1/user"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "users#post" do
    it 'when the user is created' do
      post '/api/v1/user', params: {:name => 'marcos', :email => 'marcos@hand.io', :password => 'bwy7867', :cpf => '06221220700' }
      expect(response).to have_http_status(201)
      expect(response.body).to include("Usuário foi criado")
    end

    it 'when the user is not created' do
      post '/api/v1/user'
      expect(response).to have_http_status(422)
      expect(response.body).to include("Usuário não foi criado")
    end
  end

  describe "users#put" do
    it 'when the user is updated' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      put '/api/v1/user/2', params: {:name => 'marcos', :email => 'marcos@hand.io', :password => 'bwy7867', :cpf => '06221220700'}
      @user.reload
      expect(response).to have_http_status(200)
      expect(response.body).to include("Usuário foi editado")
    end

    it 'when the user is not found' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      put '/api/v1/user/3', params: {:name => 'marcos', :email => 'marcos@hand.io', :password => 'bwy7867', :cpf => '06221220700'}
      @user.reload
      expect(response).to have_http_status(422)
      expect(response.body).to include("Usuário não foi encontrado")
    end

    it "when the user isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      put "/api/v1/user/2"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end

  describe "users#delete" do
    it 'when the user is deleted' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      delete '/api/v1/user/2'
      expect(response).to have_http_status(200)
      expect(response.body).to include("Usuário foi deletado")
    end

    it 'when the user is not found' do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(@user)
      delete '/api/v1/user/3'
      expect(response).to have_http_status(422)
      expect(response.body).to include("Usuário não foi encontrado")
    end

    it "when the user isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      delete "/api/v1/user/2"
      expect(response.body).to include("Not Authorized")
      expect(response).to have_http_status(401)
    end
  end
end

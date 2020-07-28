require 'rails_helper'

RSpec.describe "Visits", type: :request do
  before(:all) do
    @user = FactoryBot.build(:user)
    @visit = FactoryBot.create(:visit)
  end

  describe "visits#index" do
    it "should request a list of visits" do
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      get "/api/v1/visit", headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to be_successful
      expect(response.body).to include("Visitas carregadas")
      expect(response).to have_http_status(200)
    end

    it "when the user isn't authenticated" do
      get "/api/v1/visit"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "visits#post" do
    it 'when the visit is created' do
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      post '/api/v1/visit', params: {:date => '2020-08-26 11:59:02.202929584 -0300', :status => 'Realizado', :checkin_at => '2020-02-26T15:59:02.202Z', :checkout_at => '2020-02-26T18:59:02.202Z', :user_id =>  2 },  headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(201)
      expect(response.body).to include("Visita foi criada")
    end

    it 'when the visit is not created' do
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      post "/api/v1/visit", params: {:date => '2020-02-26 11:59:02.202929584 -0300', :status => 'Realizado', :checkin_at => '2020-02-26T15:59:02.202Z', :checkout_at => '2020-02-26T18:59:02.202Z', :user_id =>  2 },  headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(422)
      expect(response.body).to include("Visita não foi criada")
    end

    it "when the user isn't authenticated" do
      post "/api/v1/visit", params: {:date => '2020-02-26 11:59:02.202929584 -0300', :status => 'Realizado', :checkin_at => '2020-02-26T15:59:02.202Z', :checkout_at => '2020-02-26T18:59:02.202Z', :user_id =>  2 }
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "visits#put" do
    it 'when the visit is updated' do
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      put '/api/v1/visit/2', params: {:status => 'Pendente'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
      @visit.reload
      expect(response).to have_http_status(200)
      expect(response.body).to include("Visita foi editada")
    end

    it 'when the visit is not found' do
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      put '/api/v1/visit/3', params: {:status => 'Pendente'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(422)
      expect(response.body).to include("Visita não foi encontrada")
    end

    it "when the visit isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      put "/api/v1/visit/2"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end

  describe "visits#delete" do
    it 'when the visit is deleted' do
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      delete '/api/v1/visit/2', headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(200)
      expect(response.body).to include("Visita foi deletada")
    end

    it 'when the visit is not found' do
      authentication = AuthenticateUser.call(@user.email, @user.password, @user.cpf)
      delete '/api/v1/visit/3', headers: {"Authorization" => "Bearer #{authentication.result}"}
      expect(response).to have_http_status(422)
      expect(response.body).to include("Visita não foi encontrada")
    end

    it "when the visit isn't authenticated" do
      allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(nil)
      delete "/api/v1/visit/2"
      expect(response.body).to include("Usuário não autenticado")
      expect(response).to have_http_status(401)
    end
  end
end

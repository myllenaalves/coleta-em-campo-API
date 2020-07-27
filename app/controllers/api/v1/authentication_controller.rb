module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authenticate_request
      def_param_group :authenticate do
        param :email, String, :desc => "Email para a autenticação", :required => true
        param :password, String, :desc => "Senha para a autenticação", :required => true
      end
      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENERATING NEXT TIME
      api :POST, '/v1/authenticate', 'Autenticação de usuário'
      error code: 401
      param_group :authenticate
      def authenticate
        command = AuthenticateUser.call(params[:email], params[:password], params[:cpf])

        if command.success?
          render json: { auth_token: command.result }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      end
    end
  end
end

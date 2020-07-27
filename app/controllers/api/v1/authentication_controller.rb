module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authenticate_request

      # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENERATING NEXT TIME
      api :POST, '/v1/authenticate', 'Autenticação de usuário'
      error code: 401
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

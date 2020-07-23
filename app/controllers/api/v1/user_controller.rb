module Api
  module V1
    class UserController < ApplicationController
      skip_before_action :authenticate_request, only: [:create]

      # Listar todos os usuários
      def index
        users = User.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Usuários carregados', data:users},status: :ok
      end

      #Criar um novo usuário
      def create
				user = User.new(user_params)
				if user.save
					render json: {status: 'SUCCESS', message:'Usuário foi criado', data:user},status: :ok
				else
					render json: {status: 'ERROR', message:'Usuário não foi criado', data:user.errors},status: :unprocessable_entity
				end
			end

      #Editar um usuário
      def update
        user = User.find(params[:id])
        if user.update_attributes(user_params)
          render json: {status: 'SUCCESS', message:'Usuário foi editado', data:user},status: :ok
        else
          render json: {status: 'ERROR', message:'Usuário não foi editado', data:user.errors},status: :unprocessable_entity
        end
      end

      # Excluir usuário
			def destroy
				user = User.find(params[:id])
				user.destroy
				render json: {status: 'SUCCESS', message:'Usuário foi deletado', data:user},status: :ok
			end

      # Parametros aceitos
			private
			def user_params
				params.permit(:email, :password, :cpf)
			end
    end
  end
end

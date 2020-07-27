module Api
  module V1
    class UserController < ApplicationController
      skip_before_action :authenticate_request, only: [:create]

      def_param_group :user do
        param :name, String, :desc => "Nome do usuário"
        param :email, String, :desc => "Email para a autenticação"
        param :password, String, :desc => "Senha para a autenticação"
        param :cpf, String, :desc => "CPF do usuário"
      end

      # Listar todos os usuários
      api :GET, "/v1/user", "Lista todos os usuários"
      param_group :user
      def index
        users = User.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Usuários carregados', data:users},status: :ok
      end

      #Criar um novo usuário
      api :POST, "/v1/user", "Cria um usuário"
      def create
				user = User.new(user_params)
				if user.save
					render json: {status: 'SUCCESS', message:'Usuário foi criado', data:user},status: :created
				else
					render json: {status: 'ERROR', message:'Usuário não foi criado', data:user.errors},status: :unprocessable_entity
				end
			end

      #Editar um usuário
      api :PUT, "/v1/user/:id", "Edita um usuário"
      api :PATCH, "/v1/user/:id", "Edita um usuário"
      def update
        if User.exists?(params[:id])
          user = User.find(params[:id])
          if user.update_attributes(user_params)
            render json: {status: 'SUCCESS', message:'Usuário foi editado', data:user},status: :ok
          else
            render json: {status: 'ERROR', message:'Usuário não foi editado', data:user.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Usuário não foi encontrado'}, status: :unprocessable_entity
        end
      end

      # Excluir usuário
      api :DELETE, "/v1/user/:id", "Deleta um usuário"
			def destroy
        if User.exists?(params[:id])
          user = User.find(params[:id])
				  user.destroy
				  render json: {status: 'SUCCESS', message:'Usuário foi deletado', data:user},status: :ok
        else
          render json: {status: 'ERROR', message:'Usuário não foi encontrado'}, status: :unprocessable_entity
        end
			end

      # Parametros aceitos
			private
			def user_params
				params.permit(:email, :password, :cpf)
			end
    end
  end
end

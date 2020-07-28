module Api
  module V1
    class FormularyController < ApplicationController
      def_param_group :formulary do
        param :name, String, :desc => "Nome do formulário", :required => true
      end
      # Listar todos os formulários
      api :GET, "/v1/formulary", "Lista todos os formulários (Necessário autenticação)"
      def index
        formularies = Formulary.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Formulários carregados', data:formularies},status: :ok
      end

      #Criar um novo formulário
      api :POST, "/v1/formulary", "Cria um formulário (Necessário autenticação)"
      param_group :formulary
      def create
				formulary = Formulary.new(formulary_params)
				if formulary.save
					render json: {status: 'SUCCESS', message:'Formulário foi criado', data:formulary},status: :created
				else
					render json: {status: 'ERROR', message:'Formulário não foi criado', data:formulary.errors},status: :unprocessable_entity
				end
			end

      #Editar um formulário
      api :PUT, "/v1/formulary/:id", "Edita um formulário (Necessário autenticação)"
      api :PATCH, "/v1/formulary/:id", "Edita um formulário (Necessário autenticação)"
      def update
        if Formulary.exists?(params[:id])
          formulary = Formulary.find(params[:id])
          if formulary.update_attributes(formulary_params)
            render json: {status: 'SUCCESS', message:'Formulário foi editado', data:formulary},status: :ok
          else
            render json: {status: 'ERROR', message:'Formulário não foi editado', data:formulary.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Formulário não foi encontrado'}, status: :unprocessable_entity
        end
      end

      #Deletar um formulário
      api :DELETE, "/v1/formulary/:id", "Deleta um formulário (Necessário autenticação)"
      def destroy
        if Formulary.exists?(params[:id])
          formulary = Formulary.find(params[:id])
          formulary.destroy
          render json: {status: 'SUCCESS', message:'Formulário foi deletado', data:formulary},status: :ok
        else
          render json: {status: 'ERROR', message:'Formulário não foi encontrado'}, status: :unprocessable_entity
        end
      end


      # Parametros aceitos
			private
			def formulary_params
				params.permit(:name)
			end

    end
  end
end

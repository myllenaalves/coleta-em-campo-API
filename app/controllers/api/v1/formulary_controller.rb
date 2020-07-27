module Api
  module V1
    class FormularyController < ApplicationController
      # Listar todos os formulários
      api :GET, "/v1/answer", "Lista todos os formulários"
      def index
        formularies = Formulary.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Formulários carregados', data:formularies},status: :ok
      end

      #Criar um novo formulário
      api :POST, "/v1/answer", "Cria um formulário"
      def create
				formulary = Formulary.new(formulary_params)
				if formulary.save
					render json: {status: 'SUCCESS', message:'Formulário foi criado', data:formulary},status: :created
				else
					render json: {status: 'ERROR', message:'Formulário não foi criado', data:formulary.errors},status: :unprocessable_entity
				end
			end

      #Editar um formulário
      api :PUT, "/v1/answer/:id", "Edita um formulário"
      api :PATCH, "/v1/answer/:id", "Edita um formulário"
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
      api :DELETE, "/v1/answer/:id", "Deleta um formulário"
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

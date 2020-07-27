module Api
  module V1
    class AnswerController < ApplicationController
      # Listar todas as respotas
      api :GET, "/v1/answer", "Lista todas as respostas"
      def index
        answers = Answer.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Respostas carregadas', data:answers},status: :ok
      end

      #Criar uma nova resposta
      api :POST, "/v1/answer", "Cria uma resposta"
      def create
				answer = Answer.new(answer_params)
				if answer.save
					render json: {status: 'SUCCESS', message:'Resposta foi criada', data:answer},status: :created
				else
					render json: {status: 'ERROR', message:'Resposta não foi criada', data:answer.errors},status: :unprocessable_entity
				end
			end

      #Editar uma resposta
      api :PUT, "/v1/answer/:id", "Edita uma resposta"
      api :PATCH, "/v1/answer/:id", "Edita uma resposta"
      def update
        if Answer.exists?(params[:id])
          answer = Answer.find(params[:id])
          if answer.update_attributes(answer_params)
            render json: {status: 'SUCCESS', message:'Resposta foi editada', data:answer},status: :ok
          else
            render json: {status: 'ERROR', message:'Resposta não foi editada', data:answer.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Resposta não foi encontrada'}, status: :unprocessable_entity
        end
      end

      #Deletar uma resposta
      api :DELETE, "/v1/answer/:id", "Deleta uma resposta"
      def destroy
        if Answer.exists?(params[:id])
          answer = Answer.find(params[:id])
          answer.destroy
          render json: {status: 'SUCCESS', message:'Resposta foi deletada', data:answer},status: :ok
        else
          render json: {status: 'ERROR', message:'Resposta não foi encontrada'}, status: :unprocessable_entity
        end
      end


      # Parametros aceitos
			private
			def answer_params
				params.permit(:content, :formulary_id, :question_id, :visit_id, :answered_at)
			end

    end
  end
end

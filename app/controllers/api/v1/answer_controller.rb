module Api
  module V1
    class AnswerController < ApplicationController
      # Listar todas as respotas
      def index
        answers = Answer.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Respostas carregadas', data:answers},status: :ok
      end

      #Criar uma nova resposta
      def create
				answer = Answer.new(question_params)
				if answer.save
					render json: {status: 'SUCCESS', message:'Resposta foi criada', data:answer},status: :ok
				else
					render json: {status: 'ERROR', message:'Resposta não foi criada', data:answer.errors},status: :unprocessable_entity
				end
			end

      #Editar uma resposta
      def update
        answer = Answer.find(params[:id])
        if answer.update_attributes(answer_params)
          render json: {status: 'SUCCESS', message:'Resposta foi editada', data:answer},status: :ok
        else
          render json: {status: 'ERROR', message:'Resposta não foi editada', data:answer.errors},status: :unprocessable_entity
        end
      end

      #Deletar uma resposta
      def destroy
        answer = Answer.find(params[:id])
        answer.destroy
        render json: {status: 'SUCCESS', message:'Resposta foi deletada', data:answer},status: :ok
      end


      # Parametros aceitos
			private
			def answer_params
				params.permit(:content, :formulary_id, :question_id, :visit_id, :answered_at)
			end

    end
  end
end

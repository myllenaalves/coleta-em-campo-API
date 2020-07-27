module Api
  module V1
    class QuestionController < ApplicationController
      include ActionController::Serialization
      # Listar todas as perguntas
      api :GET, "/v1/question", "Lista todas as perguntas"
      def index
        questions = Question.all
        render json: questions, status: :ok
      end

      #Criar uma nova pergunta
      api :POST, "/v1/question", "Cria uma pergunta"
      def create
        question = Question.create!(question_params)
        render json: question, status: :created
			end

      #Editar uma pergunta
      api :PUT, "/v1/question/:id", "Edita uma pergunta"
      api :PATCH, "/v1/question/:id", "Edita uma pergunta"
      def update
        if Question.exists?(params[:id])
          question = Question.find(params[:id])
          if question.update_attributes(question_params)
            render json: {status: 'SUCCESS', message:'Pergunta foi editada', data:question},status: :ok
          else
            render json: {status: 'ERROR', message:'Pergunta não foi editada', data:question.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Pergunta não foi encontrada'}, status: :unprocessable_entity
        end
      end

      #Deletar uma pergunta
      api :DELETE, "/v1/question/:id", "Deleta uma pergunta"
      def destroy
        if Question.exists?(params[:id])
          question = Question.find(params[:id])
          question.destroy
          render json: {status: 'SUCCESS', message:'Pergunta foi deletada', data:question},status: :ok
        else
          render json: {status: 'ERROR', message:'Pergunta não foi encontrada'}, status: :unprocessable_entity
        end
      end


      # Parametros aceitos
			private
			def question_params
				params.permit(:name, :formulary_id, :question_type, :image)
			end

    end
  end
end

module Api
  module V1
    class QuestionController < ApplicationController
      include ActionController::Serialization
      def_param_group :question do
        param :name, String, :desc => "Nome da pergunta", :required => true
        param :formulary_id, String, :desc => "Id do formulário que a pergunta pertence", :required => true
        param :question_type, String, :desc => "Descrição do tipo da questão, pode ter uma imagem", :required => true
      end
      # Listar todas as perguntas
      api :GET, "/v1/question", "Lista todas as perguntas (Necessário autenticação)"
      def index
        questions = Question.all
        render json: {status: 'SUCCESS', message:'Perguntas carregadas', data:questions},status: :ok
      end

      #Criar uma nova pergunta
      api :POST, "/v1/question", "Cria uma pergunta (Necessário autenticação)"
      param_group :question
      def create
        question = Question.create!(question_params)
        render json: {status: 'SUCCESS', message:'Pergunta foi criada', data:question},status: :created
			end

      #Editar uma pergunta
      api :PUT, "/v1/question/:id", "Edita uma pergunta (Necessário autenticação)"
      api :PATCH, "/v1/question/:id", "Edita uma pergunta (Necessário autenticação)"
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
      api :DELETE, "/v1/question/:id", "Deleta uma pergunta (Necessário autenticação)"
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

module Api
  module V1
    class AnswerController < ApplicationController
      def_param_group :answer do
        param :content, String, :desc => "Conteúdo da resposta", :required => true
        param :formulary_id, String, :desc => "ID do formulário que a resposta vai pertencer", :required => true
        param :question_id, String, :desc => "ID da Pergunta que a resposta vai pertencer ", :required => true
        param :visit_id, String, :desc => "ID da Visita que a resposta vai pertencer"
      end
      # Listar todas as respotas
      api :GET, "/v1/answer", "Lista todas as respostas (Necessário autenticação)"
      def index
        answers = Answer.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Respostas carregadas', data:answers},status: :ok
      end

      #Criar uma nova resposta
      api :POST, "/v1/answer", "Cria uma resposta (Necessário autenticação)"
      param_group :answer
      def create
				answer = Answer.new(answer_params)
				if answer.save
					render json: {status: 'SUCCESS', message:'Resposta foi criada', data:answer},status: :created
				else
					render json: {status: 'ERROR', message:'Resposta não foi criada', data:answer.errors},status: :unprocessable_entity
				end
			end

      #Editar uma resposta
      api :PUT, "/v1/answer/:id", "Edita uma resposta (Necessário autenticação)"
      api :PATCH, "/v1/answer/:id", "Edita uma resposta (Necessário autenticação)"
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
      api :DELETE, "/v1/answer/:id", "Deleta uma resposta (Necessário autenticação)"
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

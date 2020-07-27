module Api
  module V1
    class VisitController < ApplicationController
      # Listar todas as visitas
      api :GET, "/v1/visit", "Lista todas as visitas"
      def index
        visits = Visit.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Visitas carregadas', data:visits},status: :ok
      end

      #Criar uma nova visita
      api :POST, "/v1/visit", "Cria uma visita"
      def create
				visit = Visit.new(visit_params)
				if visit.save
					render json: {status: 'SUCCESS', message:'Visita foi criada', data:visit},status: :created
				else
					render json: {status: 'ERROR', message:'Visita não foi criada', data:visit.errors},status: :unprocessable_entity
				end
			end

      #Editar uma visita
      api :PUT, "/v1/visit/:id", "Edita uma visita"
      api :PATCH, "/v1/visit/:id", "Edita uma visita"
      def update
        if Visit.exists?(params[:id])
          visit = Visit.find(params[:id])
          if visit.update_attributes(visit_params)
            render json: {status: 'SUCCESS', message:'Visita foi editada', data:visit},status: :ok
          else
            render json: {status: 'ERROR', message:'Visita não foi editada', data:visit.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Visita não foi encontrada'}, status: :unprocessable_entity
        end
      end

      #Deletar uma visita
      api :DELETE, "/v1/visit/:id", "Deleta uma visita"
      def destroy
        if Visit.exists?(params[:id])
          visit = Visit.find(params[:id])
          visit.destroy
          render json: {status: 'SUCCESS', message:'Visita foi deletada', data:visit},status: :ok
        else
          render json: {status: 'ERROR', message:'Visita não foi encontrada'}, status: :unprocessable_entity
        end
      end


      # Parametros aceitos
			private
			def visit_params
				params.permit(:date, :status, :user_id, :checkin_at, :checkout_at)
			end

    end
  end
end

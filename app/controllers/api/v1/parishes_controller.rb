module API
  module V1
    class ParishesController < ApplicationController
      before_action :set_parish, only: [:show, :edit, :update, :destroy]

      # GET /parishes
      # GET /parishes.json
      # GET /parishes.csv
      def index
        @parishes = Parish.includes(:service)
        respond_to do |format|
          format.html { render :new }
          format.json { render json: JSON.pretty_generate(@parishes.to_a.map(&:serializable_hash)) }
          format.csv do
            headers['Content-Disposition'] = "attachment; filename=\"parish-list\""
            headers['Content-Type'] ||= 'text/csv'
          end
        end
      end

      # GET /parishes/1
      # GET /parishes/1.json
      def show
        #  render json: {params}
      end

      # GET /parishes/new
      def new
        @parish = Parish.new
      end

      # GET /parishes/1/edit
      def edit
      end

      # POST /parishes
      # POST /parishes.json
      def create
        @parish = Parish.new(parish_params)

        respond_to do |format|
          if @parish.save
            # format.html { redirect_to @parish, notice: 'Parish was successfully created.' }
            format.json { render json:@parish, status: :created }
          else
            # format.html { render :new }
            format.json { render json: @parish.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /parishes/1
      # PATCH/PUT /parishes/1.json
      def update
        respond_to do |format|
          if @parish.update(parish_params)
            format.html { redirect_to @parish, notice: 'Parish was successfully updated.' }
            format.json { render json:@parish, status: :updated }
          else
            format.html { render :edit }
            format.json { render json: @parish.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /parishes/1
      # DELETE /parishes/1.json
      def destroy
        @parish.destroy
        respond_to do |format|
          format.html { redirect_to parishes_url, notice: 'Parish was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_parish
        @parish = Parish.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def parish_params
        params.require(:parish).permit(:name, :in_charge, :location, :updated_at, :created_at)
      end
    end
  end
end

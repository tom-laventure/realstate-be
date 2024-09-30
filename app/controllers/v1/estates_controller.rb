class V1::EstatesController < ApplicationController
    include UserValidation

    before_action :auth_user
    before_action :set_group
    before_action :set_estate, only: [:show, :update, :destroy]
  
    # GET /estates
    def index
      estates = @group.estates
      render json: EstateSerializer.new(estates).serializable_hash, status: :ok
    end
  
    # GET /estates/:id
    def show
      render json: { status: 200, data: @estate }, status: :ok
    end
  
    # POST /estates
    def create
      estate = @group.estates.new(estate_params)
  
      if estate.save
        render json: { status: 200, message: 'Estate successfully created', data: estate }, status: :ok
      else
        render json: { status: 422, message: 'Error creating estate', errors: estate.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PUT /estates/:id
    def update
      if @estate.update(estate_params)
        render json: { status: 200, message: 'Estate successfully updated', data: @estate }, status: :ok
      else
        render json: { status: 422, message: 'Error updating estate', errors: @estate.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /estates/:id
    def destroy
      if @estate.destroy
        render json: { status: 200, message: 'Estate successfully deleted' }, status: :ok
      else
        render json: { status: 422, message: 'Error deleting estate' }, status: :unprocessable_entity
      end
    end
  
    private

    def set_group
      @group = @current_user.groups.find(params['group_id'])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Group not found' }, status: :not_found
    end
  

    def set_estate
      @estate = @group.estates.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Estate not found' }, status: :not_found
    end
  

    def estate_params
      params.require(:estate).permit(:header, :link)
    end
  end
  
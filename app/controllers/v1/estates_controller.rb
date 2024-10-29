class V1::EstatesController < ApplicationController
    include UserValidation

    before_action :auth_user
    before_action :set_group
    before_action :set_estate, only: [:show, :update, :destroy]
  
    # GET /estates
    def index
      estates = {
        estates: ActiveModelSerializers::SerializableResource.new(@group.estates, each_serializer: EstateSerializer),
        groups: ActiveModelSerializers::SerializableResource.new(@current_user.groups, each_serializer: GroupSerializer)
      }
      render json: estates, status: :ok
    end
  
    # GET /estates/:id
    def show
      estates = {
        estates: ActiveModelSerializers::SerializableResource.new(@group.estates, each_serializer: EstateSerializer),
        selected_estate: ActiveModelSerializers::SerializableResource.new(@estate, serializer: EstateSerializer, current_user: current_user)
      } 

      render json: estates, status: :ok   
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
      @group = @current_user.groups.without_deleted.find(params['group_id'])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Group not found' }, status: :not_found
    end
  

    def set_estate
      @estate = @group.estates.without_deleted.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Estate not found' }, status: :not_found
    end
  

    def estate_params
      params.require(:estate).permit(:header, :link)
    end
  end
  
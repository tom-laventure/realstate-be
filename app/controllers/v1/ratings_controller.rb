class V1::RatingsController < ApplicationController
    include UserValidation

    before_action :set_estate
    before_action :set_rating, only: [:show, :update, :destroy]
    before_action :auth_user
  
    # GET /v1/ratings
    def index
      ratings = @estate.ratings
      render json: ratings, status: :ok
    end
  
    # GET /v1/ratings/:id
    def show
      render json: @rating, status: :ok
    end
  
    # POST /v1/ratings
    def create
      rating = @estate.ratings.build(rating_params)
      rating.user = @current_user
  
      if rating.save
        render json: { status: 200, message: 'Rating successfully created', data: rating }, status: :created
      else
        render json: { status: 422, message: 'Error creating rating', errors: rating.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PUT /v1/ratings/:id
    def update
      if @rating.update(rating_params)
        render json: { status: 200, message: 'Rating successfully updated', data: @rating }, status: :ok
      else
        render json: { status: 422, message: 'Error updating rating', errors: @rating.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /v1/ratings/:id
    def destroy
      if @rating.destroy
        render json: { status: 200, message: 'Rating successfully deleted' }, status: :ok
      else
        render json: { status: 422, message: 'Error deleting rating' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_estate
      @estate = Estate.find(params['estate_id'])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Estate not found' }, status: :not_found
    end
  
    def set_rating
      @rating = @estate.ratings.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Rating not found' }, status: :not_found
    end
  
    def rating_params
      params.require(:rating).permit(:score, :comment)
    end
  end
  
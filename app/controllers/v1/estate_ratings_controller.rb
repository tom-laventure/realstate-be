class V1::EstateRatingsController < ApplicationController
    include UserValidation

    before_action :auth_user
    before_action :set_estate
    before_action :set_rating, only: [:show, :update, :destroy]
  
    # GET /v1/estate_ratings
    def index
      ratings = ratings_scope
      render json: ratings, status: :ok
    end
  
    # GET /v1/estate_ratings/:id
    def show
      render json: @rating, status: :ok
    end
  
    # POST /v1/estate_ratings
    def create
      rating = @estate.estate_ratings.build(rating_params)
      rating.user = @current_user

      if rating.save
        ratings = ratings_scope
        render json: {
          estate_ratings: ActiveModelSerializers::SerializableResource.new(ratings, each_serializer: EstateRatingSerializer),
          user_rating: EstateRatingSerializer.new(rating)
        }, status: :created
      else
        render json: { status: 422, message: 'Error creating rating', errors: rating.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PUT /v1/estate_ratings/:id
    def update
      if @rating.update(rating_params)
        render json: {
          estate_ratings: ActiveModelSerializers::SerializableResource.new(@estate.estate_ratings, each_serializer: EstateRatingSerializer),
          user_rating: EstateRatingSerializer.new(@rating)
      }, status: :ok
      else
        render json: { status: 422, message: 'Error updating rating', errors: @rating.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /v1/estate_ratings/:id
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
      @rating = @estate.estate_ratings.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Rating not found' }, status: :not_found
    end
  
    def rating_params
      params.permit(:estate_id, :rating)
    end

    def ratings_scope
      # eager-load user to avoid N+1 in serializers
      @estate.estate_ratings.includes(:user).order(created_at: :desc)
    end
  end

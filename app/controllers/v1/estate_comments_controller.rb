class V1::EstateCommentsController < ApplicationController
  include UserValidation

    before_action :auth_user
    before_action :set_estate
    before_action :set_comment, only: [:show, :update, :destroy]
  
    # GET /v1/estate_comments
    def index
      comments = @estate.estate_comments
      render json: comments, status: :ok
    end
  
    # GET /v1/estate_comments/:id
    def show
      render json: @comment, status: :ok
    end
  
    # POST /v1/estate_comments
    def create
      comment = @estate.estate_comments.build(comment_params)
      comment.user = @current_user
  
      if comment.save
        render json: comment, status: :created
      else
        render json: { status: 422, message: 'Error creating comment', errors: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PUT /v1/estate_comments/:id
    def update
      if @comment.update(comment_params)
        render json: @comment, status: :ok
      else
        render json: { status: 422, message: 'Error updating comment', errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /v1/estate_comments/:id
    def destroy
      if @comment.destroy
        render json: @estate.estate_comments, status: :ok
      else
        render json: { status: 422, message: 'Error deleting comment' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_estate
      @estate = Estate.find(params['estate_id'])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Estate not found' }, status: :not_found
    end
  
    def set_comment
      @comment = @estate.estate_comments.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Comment not found' }, status: :not_found
    end
  
    def comment_params
      params.permit(:comment, :comment_type, :estate_id)
    end
  end
  
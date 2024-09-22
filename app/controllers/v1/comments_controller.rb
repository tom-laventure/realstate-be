class V1::CommentsController < ApplicationController
    before_action :set_estate
    before_action :set_comment, only: [:show, :update, :destroy]
    before_action :auth_user
  
    # GET /v1/comments
    def index
      comments = @estate.comments
      render json: comments, status: :ok
    end
  
    # GET /v1/comments/:id
    def show
      render json: @comment, status: :ok
    end
  
    # POST /v1/comments
    def create
      comment = @estate.comments.build(comment_params)
      comment.user = @current_user
  
      if comment.save
        render json: { status: 200, message: 'Comment successfully created', data: comment }, status: :created
      else
        render json: { status: 422, message: 'Error creating comment', errors: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PUT /v1/comments/:id
    def update
      if @comment.update(comment_params)
        render json: { status: 200, message: 'Comment successfully updated', data: @comment }, status: :ok
      else
        render json: { status: 422, message: 'Error updating comment', errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /v1/comments/:id
    def destroy
      if @comment.destroy
        render json: { status: 200, message: 'Comment successfully deleted' }, status: :ok
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
      @comment = @estate.comments.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Comment not found' }, status: :not_found
    end
  
    def comment_params
      params.require(:comment).permit(:type, :comment)
    end
  end
  
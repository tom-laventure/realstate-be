class V1::SubcommentsController < ApplicationController
  include UserValidation
  before_action :auth_user
  before_action :set_estate_comment, only: [:create, :index]
  before_action :set_subcomment, only: [:show, :update, :destroy]

  def index
    subcomments = @estate_comment.subcomments.includes(:user).order(created_at: :asc)
    render json: subcomments, each_serializer: SubcommentSerializer, current_user: current_user
  end

  def show
    render json: @subcomment, serializer: SubcommentSerializer, current_user: current_user
  end

  def create
    subcomment = @estate_comment.subcomments.new(subcomment_params.merge(user: current_user))
    if subcomment.save
      
      render json: subcomment, serializer: SubcommentSerializer, current_user: current_user, status: :created
    else
      render json: { status: 422, message: 'Failed to create subcomment', errors: subcomment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @subcomment.update(subcomment_params)
      render json: @subcomment, serializer: SubcommentSerializer, current_user: current_user
    else
      render json: { status: 422, message: 'Failed to update subcomment', errors: @subcomment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    estate_comment = @subcomment.estate_comment
    @subcomment.destroy
    
    render json: { status: 200, message: 'Subcomment deleted successfully' }
  end

  private

  def set_estate_comment
    @estate_comment = EstateComment.without_deleted.find(params['estate_comment_id'])
  rescue ActiveRecord::RecordNotFound
    render json: { status: 404, message: 'Estate comment not found' }, status: :not_found
  end

  def set_subcomment
    @subcomment = Subcomment.without_deleted.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: 404, message: 'Subcomment not found' }, status: :not_found
  end

  def subcomment_params
    params.permit(:comment)
  end
end

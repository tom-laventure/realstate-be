class V1::MessagesController < ApplicationController
  include UserValidation
  before_action :auth_user
  before_action :set_group

  def create
        message = @group.messages.build(message_params)
        message.user = @current_user

        if message.save!
          # Broadcast the message to the chat channel
          ChatChannel.broadcast_to(@group, {
            message: message
          })
          render json: { status: 200, message: 'Message successfully created', data: message }, status: :ok
        else
          render json: { status: 422, message: 'Error creating message', errors: message.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    private
    def set_group
      @group = @current_user.groups.without_deleted.find(params['group_id'])
    rescue ActiveRecord::RecordNotFound
      render json: { status: 404, message: 'Group not found' }, status: :not_found
    end

    private
    def message_params
      params.permit(:message, :group_id)
    end
end

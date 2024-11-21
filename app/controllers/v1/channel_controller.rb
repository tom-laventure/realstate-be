class V1::ChannelController < ApplicationController
    before_action :auth_user
    before_action :set_channel
    before_action :set_group, only: [:create]
    
    # GET /channel
    def index
        user_channels = Channel.joins(:group_channels).where(group_channels: { user: current_user, group_id: params[:group_id] }).without_deleted

        render json: user_channels, status: :ok
    end

    # GET /channel/:id
    def show
        render json: @channel
    end

    # POST /channel/:id
    def add_to_channel
        group_channel = @channel.group_channel.build(channel_params)

        if group_channel.save
            render json: { status: 200, message: 'User added to channel', data: @channel }, status: :ok
        else
            render json: { status: 422, message: 'Error adding user to channel', errors: @channel.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def create
        channel = Channel.create!(name: params[:name])
        group_channel = GroupChannel.create(
            user_id: current_user.id,
            group_id: @group.id,
            channel_id: channel.id
        )

        render json: { 
            status: 201, 
            message: 'Channel created successfully', 
            data: channel 
          }, status: :created
        rescue ActiveRecord::RecordInvalid => e
          render json: { 
            status: 422, 
            message: 'Error creating channel', 
            errors: e.record.errors.full_messages 
          }, status: :unprocessable_entity
    end

    private

    def set_channel
        @channel = Channel.without_deleted.find(params[:id])
    end

    def set_group
        @group = Group.without_deleted.find(params[:group_id])
    end

    def channel_params
        params.permit(:user_id, :group_id)
    end
end

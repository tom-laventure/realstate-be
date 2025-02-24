class V1::GroupsController < ApplicationController
    include UserValidation
    before_action :auth_user
    before_action :set_group, only: [:show, :join_group]

    def show
        if @group.users.find(@current_user.id)
            render json: {in_group: true, group: @group}
        else 
            render json: {in_group: false, group: @group}
        end
    end

    def join_group
        begin
            @group.users << @current_user unless @group.users.include?(@current_user)

            render json: @group
        rescue => e
            logger.error "Error adding user to group #{e.message}"
        end
    end

    def retrieve
        groups = @current_user.groups.includes(group_channels: :channel).without_deleted
        render json: groups, each_serializer: GroupSerializer, current_user: @current_user, active_group: param[:id]
    end

    def create
        group_params = params.require(:name)

        group = {
            name: params['name']
        }

        @current_user.groups.create(group)

        if @current_user.save()
            render json: @current_user.groups
        else
            render json: {status: 404, message: 'error creating group'}
        end
    end

    def destroy
        group = @current_user.groups.find_by(id: params[:id])

        if group.nil?
            render json: {status: 404, message: 'group not found'}
        elsif group.destroy
            render json: {
              status: 200,
              message: 'Group successfully deleted'
            }
        else
            render json: {
              status: 422,
              message: 'Error deleting group'
            }
        end
    end

    def update
        params.require(:name)

        group = @current_user.groups.find_by(id: params[:id])
    
        if group.nil?
            render json: {status: 404, message: 'group not found'}
        elsif group.update(name: params['name'])
            render json: {
                status: 200,
                message: 'Group successfully updated',
                data: {
                  group: group
                }
              }
        else
            render json: {
                status: 422,
                message: 'Error updating group',
                errors: group.errors.full_messages
              }
        end
    end

    def set_group
        @group = Group.find(params[:id])
    end
end
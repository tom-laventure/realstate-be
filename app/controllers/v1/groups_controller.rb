class V1::GroupsController < ApplicationController
    include UserValidation
    before_action :auth_user

    def retrieve
        groups = @current_user.groups.without_deleted 
        render json: groups
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
end
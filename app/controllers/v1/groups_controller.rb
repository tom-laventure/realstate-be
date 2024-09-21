class V1::GroupsController < ApplicationController
    include UserValidation
    before_action :auth_user

    def retrieve
        groups = @current_user.groups
        render json: groups, status: :ok
    end

    def create
        group = {
            name: params['name']
        }

        @current_user.groups.create(group)

        if @current_user.save()
            render json: {status: 200, message: 'group successfully created'}
        else
            render json: {status: 404, message: 'error creating group'}
        end 
    end
end
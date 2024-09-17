class V1::UsersController < ApplicationController
    before_action :set_user, only: [:groups]

    def groups
        groups = user.groups
        render json: groups, status: :ok
    end

    private
    def set_user
        @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render 
end

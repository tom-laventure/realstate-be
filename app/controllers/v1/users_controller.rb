class V1::UsersController < ApplicationController
    include UserValidation
    before_action :auth_user
  
    def groups
      groups = @current_user.groups
      render json: groups, status: :ok
    end
  end
  
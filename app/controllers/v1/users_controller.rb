class V1::UsersController < ApplicationController
    include UserValidation
    before_action :auth_user


    def index
      render json: current_user
    end
  end
  
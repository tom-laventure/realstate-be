class V1::UsersController < ApplicationController
    include UserValidation
    before_action :auth_user

  end
  
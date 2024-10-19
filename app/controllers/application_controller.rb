class ApplicationController < ActionController::API   
    include Pagination
    before_action :configure_permitted_parameters, if: :devise_controller?
    # skip_before_action :verify_authenticity_token
    respond_to :json

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
        devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
    end
  end
module UserValidation
    extend ActiveSupport::Concern

    def auth_user
      @current_user = authenticated_user
    end
  
    def authenticated_user
      if request.headers['Authorization'].present?
        begin
          jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
          user = User.find(jwt_payload['sub'])
          if user.jti != jwt_payload['jti']
            render json: { error: 'Token has been revoked' }, status: :unauthorized
          end
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
        user
      else
        render json: { error: 'Authorization header missing' }, status: :unauthorized
      end
    end
  end
  
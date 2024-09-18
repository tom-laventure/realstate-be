module UserValidation
    extend ActiveSupport::Concern

    included do
        before_action :authenticated_user!
    end

    private
    def authenticated_user!
        if request.headers['Authorization'].present?
            begin
                jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
                @current_user = User.find(jwt_payload['sub'])
            rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
                render json: { error: 'Unauthorized' }, status: :unauthorized
            end
        else
            render json: {
                error: 'Unauthorized'
            }, status: :unauthorized
        end
    end

    def current_user
        @current_user
    end
end
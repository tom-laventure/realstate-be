# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include ActionController::Cookies
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = request.params[:token]
      if token.present?
        jwt_payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!).first
        current_user = User.find(jwt_payload['sub'])
        if verified_user = User.find_by(id: current_user)
          verified_user
        else
          reject_unauthorized_connection
        end
      end
    end
  end
end

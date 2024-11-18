class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups

  has_many :estate_comments, dependent: :destroy
  has_many :estate_ratings, dependent: :destroy

  has_many :messages, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  devise :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  attribute :name

  def self.from_omniauth(auth)
    find_or_create_by!(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end  

  # user.rb
  def jwt_payload
    self.jti = self.class.generate_jti
    self.save

    # super isn't doing anything useful, but if the gem updates i'll want it to be safe
    super.merge({
      jti: self.jti,
      usr: self.id,
      name: self.name
    })
  end

end

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups

  has_many :estate_comments, dependent: :destroy
  has_many :estate_ratings, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self


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

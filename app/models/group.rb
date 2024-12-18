class Group < ApplicationRecord
    acts_as_paranoid
    
    has_many :estates, dependent: :destroy
    
    has_many :user_groups, dependent: :destroy
    has_many :users, through: :user_groups
    
    has_many :messages, dependent: :destroy
    
    has_many :group_channels, dependent: :destroy
    has_many :channels, through: :group_channels

    validates :name, presence: true, length: { minimum: 2 } 

    def order_estates(order, user)
        case order
        when "asc"
            estates_ordered_by_created_at(:asc)
        when "desc"
            estates_ordered_by_created_at(:desc)
        when "avg"
            estates_ordered_by_avg_rating
        when "user-avg"
            estates_ordered_by_user_rating(user)
        else
            estates
        end
    end

    def estates_ordered_by_avg_rating
        estates.left_joins(:estate_ratings)
               .group("estates.id")
               .select("estates.*, COALESCE(AVG(estate_ratings.rating), 0) AS average_rating")
               .order("average_rating DESC")
    end

    def estates_ordered_by_user_rating(user)
        estates.joins(:estate_ratings)
               .where(estate_ratings: { user_id: user.id })
               .group("estates.id")
               .select("estates.*, MAX(estate_ratings.rating) AS user_max_rating")
               .order("user_max_rating DESC")
    end

    def estates_ordered_by_created_at(order)
        estates.order(created_at: order)
    end
end

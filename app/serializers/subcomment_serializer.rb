class SubcommentSerializer < ActiveModel::Serializer
  attributes :comment

  belongs_to :user
end

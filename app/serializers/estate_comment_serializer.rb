class EstateCommentSerializer < ActiveModel::Serializer
  attributes :comment

  belongs_to :user, serializer: UserSerializer
  has_many :subcomments
end

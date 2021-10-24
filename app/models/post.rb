class Post < ApplicationRecord
  belongs_to :user
  belongs_to :post_category
  has_many :comments, class_name: 'PostComment', dependent: :restrict_with_exception
  has_many :likes, class_name: 'PostLike', dependent: :restrict_with_exception
end

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :post_category
  has_many :comments, class_name: 'PostComment', dependent: :restrict_with_exception
  has_many :likes, class_name: 'PostLike', dependent: :restrict_with_exception

  validates :title, :body, :post_category_id, presence: true
end

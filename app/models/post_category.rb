class PostCategory < ApplicationRecord
  has_many :post, dependent: :restrict_with_exception
end

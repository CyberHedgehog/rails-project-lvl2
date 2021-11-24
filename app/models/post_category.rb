# frozen_string_literal: true

class PostCategory < ApplicationRecord
  has_many :post, dependent: :restrict_with_exception
end

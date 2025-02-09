# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry

  belongs_to :post
  belongs_to :user

  validates :content, presence: true, length: { minimum: 3, maximum: 1000 }
end

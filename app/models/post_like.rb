class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post, uniqueness: { scope: :user }
end

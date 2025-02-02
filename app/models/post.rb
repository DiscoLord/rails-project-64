class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, class_name: "PostComment", dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end

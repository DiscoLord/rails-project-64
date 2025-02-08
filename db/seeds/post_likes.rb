# frozen_string_literal: true

if PostLike.exists?
  Rails.logger.debug '📌 Post likes already exist. Skipping...'
else
  users = User.all
  posts = Post.all

  users.each do |user|
    posts.sample(rand(3..7)).each do |post|
      PostLike.create!(user: user, post: post)
    end
  end
  Rails.logger.debug '✅ Post likes created!'
end

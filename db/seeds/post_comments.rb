# frozen_string_literal: true

if PostComment.exists?
  Rails.logger.debug '📌 Comments already exist. Skipping...'
else
  users = User.all
  posts = Post.all

  posts.each do |post|
    rand(2..5).times do
      comment = PostComment.create!(
        content: Faker::Lorem.characters(number: rand(3..1000)),
        post: post,
        user: users.sample
      )

      # Создание вложенного комментария (ответ)
      next unless rand < 0.5

      PostComment.create!(
        content: Faker::Lorem.characters(number: rand(3..1000)),
        post: post,
        user: users.sample,
        parent: comment
      )
    end
  end
  Rails.logger.debug '✅ Post comments created!'
end

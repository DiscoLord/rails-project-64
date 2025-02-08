# frozen_string_literal: true

if Post.exists?
  Rails.logger.debug '📌 Posts already exist. Skipping...'
else
  users = User.all
  categories = Category.all

  10.times do
    Post.create!(
      title: Faker::Lorem.characters(number: rand(5..255)), # Минимум 5 символов
      body: Faker::Lorem.paragraph_by_chars(number: rand(200..4000)),
      creator: users.sample,
      category: categories.sample
    )
  end
  Rails.logger.debug '✅ Posts created!'
end

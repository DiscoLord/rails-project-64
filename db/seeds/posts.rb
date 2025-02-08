# frozen_string_literal: true

if Post.exists?
  Rails.logger.debug '📌 Posts already exist. Skipping...'
else
  users = User.all
  categories = Category.all

  10.times do
    Post.create!(
      title: Faker::Lorem.sentence(word_count: 6),
      body: Faker::Lorem.paragraph(sentence_count: 10),
      creator: users.sample,
      category: categories.sample
    )
  end
  Rails.logger.debug '✅ Posts created!'
end

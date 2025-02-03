# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

User.destroy_all
Category.destroy_all
Post.destroy_all

Array.new(10) do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password'
  )
end

Category.create!([
                   { name: 'Новости' },
                   { name: 'Спорт' },
                   { name: 'Технологии' },
                   { name: 'Развлечения' }
                 ])

30.times do
  Post.create!(
    title: Faker::Lorem.sentence(word_count: 6),
    body: Faker::Lorem.paragraph(sentence_count: 10),
    user: User.all.sample,
    category: Category.all.sample
  )
end

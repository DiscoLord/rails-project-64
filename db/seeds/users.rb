# frozen_string_literal: true

if User.exists?
  Rails.logger.debug '📌 Users already exist. Skipping...'
else
  5.times do
    User.create!(
      email: Faker::Internet.unique.email,
      password: 'password',
      password_confirmation: 'password'
    )
  end
  Rails.logger.debug '✅ Users created!'
end

# frozen_string_literal: true

if Category.exists?
  Rails.logger.debug '📌 Categories already exist. Skipping...'
else
  Category.create!([
                     { name: 'Новости' },
                     { name: 'Спорт' },
                     { name: 'Технологии' },
                     { name: 'Развлечения' }
                   ])
  Rails.logger.debug '✅ Categories created!'
end

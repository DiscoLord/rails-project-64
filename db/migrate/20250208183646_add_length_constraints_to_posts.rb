class AddLengthConstraintsToPosts < ActiveRecord::Migration[7.2]
  def change
    change_column :posts, :title, :string, limit: 255
    change_column :posts, :body, :text, limit: 4000
    change_column :post_comments, :content, :text, limit: 1000
  end
end

class CreatePostComments < ActiveRecord::Migration[7.2]
  def change
    create_table :post_comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :ancestry

      t.timestamps
    end
  end
end

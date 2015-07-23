class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :number
      t.text :description
      t.text :content
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :category_id
    add_index :posts, :title, :unique => true
  end

  def self.down
    drop_table :posts
  end
end

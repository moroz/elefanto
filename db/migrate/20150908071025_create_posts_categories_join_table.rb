class CreatePostsCategoriesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :posts, :categories
  end
end

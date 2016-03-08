class AddUniqueIndexToPosts < ActiveRecord::Migration
  def change
    remove_index :posts, :url
    add_index :posts, :url, unique: true
  end
end

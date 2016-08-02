class AddPublishedPublishedAtToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :published, :boolean, default: true
    add_column :posts, :published_at, :timestamp
  end
end

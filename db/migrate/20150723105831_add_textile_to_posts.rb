class AddTextileToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :textile_enabled, :boolean, :default => false
    add_column :posts, :views, :integer, :default => 0
  end

  def down
    remove_column :posts, :textile_enabled
    remove_column :posts, :views
  end
end

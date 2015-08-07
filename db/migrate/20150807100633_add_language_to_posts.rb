class AddLanguageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :language, :string, :default => "en"
  end

  def down
    remove_column :posts, :language
  end
end

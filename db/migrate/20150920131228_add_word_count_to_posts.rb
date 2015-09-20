class AddWordCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :word_count, :integer, :default => 0
  end
end

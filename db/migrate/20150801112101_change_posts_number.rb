class ChangePostsNumber < ActiveRecord::Migration
  def up
    change_table :posts do |t|
      t.change :number, :float
    end
  end

  def down
    change_table :posts do |t|
      t.change :number, :integer
    end
  end
end

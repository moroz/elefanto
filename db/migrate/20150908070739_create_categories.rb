class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name_en
      t.string :name_pl
      t.string :name_zh
      t.string :description

      t.timestamps null: false
    end
  end
end

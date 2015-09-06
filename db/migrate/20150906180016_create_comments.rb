class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.string :signature
      t.integer :post_id, null: false

      t.timestamps null: false
    end
  end
end

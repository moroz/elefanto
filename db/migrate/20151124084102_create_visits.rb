class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :post_id
      t.string :ip
      t.string :browser
      t.string :city
      t.string :country
      t.timestamp :timestamp
    end
  end
end

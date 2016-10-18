class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :email
      t.string :language
      t.boolean :active

      t.timestamps
    end
  end
end

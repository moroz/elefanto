class CreateSubscriptionCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :subscription_countries do |t|
      t.string :name
    end
  end
end

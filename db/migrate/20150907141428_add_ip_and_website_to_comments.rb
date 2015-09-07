class AddIpAndWebsiteToComments < ActiveRecord::Migration
  def up
    add_column :comments, :ip, :string
    add_column :comments, :website, :string
  end

  def down
    remove_column :comments, :ip
    remove_column :comments, :website
  end
end

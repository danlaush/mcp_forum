class RemoveAdminAddUserType < ActiveRecord::Migration
  def self.up
    remove_column :users, :admin
    add_column :users, :user_type, :integer, :default => 2
  end

  def self.down
    remove_column :users, :user_type
    add_column :users, :admin, :boolean, :default => false
  end
end
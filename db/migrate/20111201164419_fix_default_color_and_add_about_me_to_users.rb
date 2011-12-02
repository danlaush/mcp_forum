class FixDefaultColorAndAddAboutMeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :about, :text
    change_column :users, :color, :string, :default => "bbbbbb"
  end

  def self.down
    remove_column :users, :about
    change_column :users, :color, :string, :default => "#bbbbbb"
  end
end

class ChangeUserAdminToInteger < ActiveRecord::Migration
  def self.up 
    change_column :users, :admin, :integer
  end

  def self.down
    change_column :users, :admin, :boolean  
  end
end

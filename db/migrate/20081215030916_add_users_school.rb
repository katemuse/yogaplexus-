class AddUsersSchool < ActiveRecord::Migration
  def self.up 
    add_column :users, :school, :text    
  end

  def self.down  
    remove_column :users, :school
  end
end

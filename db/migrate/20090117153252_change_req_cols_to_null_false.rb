class ChangeReqColsToNullFalse < ActiveRecord::Migration
  def self.up         
    change_column :asanas, :english, :string, :null => false   
    change_column :asanas, :sanskrit, :string, :null => false
    change_column :asana_types, :name, :string, :null => false   

  end

  def self.down
    change_column :asanas, :english, :string, :null => true   
    change_column :asanas, :sanskrit, :string, :null => true
    change_column :asana_types, :name, :string, :null => true
  end
end

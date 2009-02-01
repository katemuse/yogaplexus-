class AddAsanaRootAsanaId < ActiveRecord::Migration
  def self.up 
    add_column :asanas, :root_asana_id, :integer
  end

  def self.down  
    remove_column :asanas, :root_asana_id
  end
end

require 'active_record/fixtures' 
class AddAsanaData < ActiveRecord::Migration
  def self.up 
    down 
    directory = File.join(File.dirname(__FILE__), 'dev_data') 
    Fixtures.create_fixtures(directory, "asanas")
    Fixtures.create_fixtures(directory, "asana_types")  
    Fixtures.create_fixtures(directory, "asana_subtypes")           
  end 
  def self.down 
    Asana.delete_all
    AsanaType.delete_all
    AsanaSubtype.delete_all    
  end
end

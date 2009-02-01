
require 'active_record/fixtures' 
class AddScrapedAsanaData < ActiveRecord::Migration
  def self.up 
    #down 
    directory = File.join(File.dirname(__FILE__), 'dev_data_scraped') 
    Fixtures.create_fixtures(directory, "asanas")        
  end 
  def self.down 
    Asana.delete_all(conditions= ['id > ?', 6])   
  end
end

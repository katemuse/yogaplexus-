require 'active_record/fixtures' 
class AddPicturesFromYml < ActiveRecord::Migration     
  def self.up 
    down 
    directory = File.join(File.dirname(__FILE__), 'dev_data') 
    Fixtures.create_fixtures(directory, "pictures") 
    Fixtures.create_fixtures(directory, "users")    
    Fixtures.create_fixtures(directory, "asanas_sequences") 
    Fixtures.create_fixtures(directory, "sequences") 
    Fixtures.create_fixtures(directory, "user_observations")    
    Fixtures.create_fixtures(directory, "asanas_sequences")    
  end 
  def self.down 
    Picture.delete_all
  end
end
                  
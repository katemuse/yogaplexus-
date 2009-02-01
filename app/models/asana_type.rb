class AsanaType < ActiveRecord::Base  
  has_many :asanas  
  validates_presence_of :name
  
        
end

class UserObservation < ActiveRecord::Base  
  belongs_to :user
  belongs_to :asana 
  has_many :pictures, :dependent => :destroy 

  validates_presence_of :title, :comment  
  validates_associated :asana 
    
end

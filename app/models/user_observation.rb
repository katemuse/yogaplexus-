class UserObservation < ActiveRecord::Base  
  belongs_to :user
  belongs_to :asana 
  has_many :pictures, :dependent => :destroy 
  has_many :replies, :class_name => 'UserObservation', :foreign_key => :reply_to_id 
  belongs_to :reply_to, :class_name => 'UserObservation', :foreign_key => :reply_to_id  
  validates_presence_of :title, :comment  
  validates_associated :asana 
    
end

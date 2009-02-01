class Sequence < ActiveRecord::Base  
  belongs_to :user 

  has_many :postures, :class_name => "AsanasSequences", :order => :position
  has_many :asanas, :through => :asanas_sequences     
  
  validates_presence_of     :user_id    
  validates_associated :user
end

class AsanasSequences < ActiveRecord::Base   
  belongs_to :sequence
  belongs_to :asana 
  acts_as_list :scope => :sequence  
  
   validates_presence_of :asana_id, :sequence_id   
   
   
end

class Picture < ActiveRecord::Base      
  belongs_to :asana
  belongs_to :user_observation 

  
  
  has_attachment :content_type => :image, :storage => :file_system, :max_size => 500.kilobytes, :resize_to => '384x256>', 
                :thumbnails => {
                  :large => '200x200>',
                  :medium => '100x100>',
                  :small => '70x70>'  
                }
    validates_as_attachment 
end
   
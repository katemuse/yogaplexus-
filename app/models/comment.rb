class Comment < ActiveRecord::Base   
  belongs_to :user
  belongs_to :post
  #this hasn't yet been implemented
  validates_presence_of :title, :content
  
end

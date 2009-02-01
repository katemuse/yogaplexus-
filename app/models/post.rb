class Post < ActiveRecord::Base   
  #This hasn't yet been implemented
  belongs_to :user     
  has_many :comments
end

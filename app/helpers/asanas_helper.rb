require 'rubygems'
require 'open-uri'
require 'nokogiri'
 
module AsanasHelper   
   
## From image_upload using attachment_fu, tutorial written by its creator, Rick Olsen:

  def picture_for(asana, size = :large)
    if asana.picture
      picture_image = asana.picture.public_filename(size)
      link_to image_tag(picture_image), asana.picture.public_filename
    else
      image_tag("blank-picture-#{size}.png")
    end
  end
end



class AsanaService  ## image_upload using attachment_fu

  attr_reader :asana, :picture
  
  def initialize(asana, picture)
    @asana = asana
    @picture = picture
  end
  
  def save
    return false unless valid?
    begin
      Asana.transaction do
        if @picture.new_record?
          @asana.picture.destroy if @asana.picture
          @picture.asana = @asana
          @picture.save!
        end
        @asana.save!
        true
      end
    rescue
      false
    end
  end
  
  def valid?
    @asana.valid? && @picture.valid?
  end  
  
  def update_attributes(asana_attributes, picture_file)
    @asana.attributes = asana_attributes
    unless picture_file.blank?
      @picture = Picture.new(:uploaded_data => picture_file)
    end
    save
  end
  
end
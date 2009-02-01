class AddPictureColumns < ActiveRecord::Migration
  def self.up  
    add_column :pictures, :size, :integer
    add_column :pictures, :content_type, :string
    add_column :pictures, :filename, :string
    add_column :pictures, :parent_id, :integer
    add_column :pictures, :thumbnail, :string
  end

  def self.down  
    remove_column :pictures, :size
    remove_column :pictures, :content_type
    remove_column :pictures, :filename
    remove_column :pictures, :parent_id
    remove_column :pictures, :thumbnail
  end
end

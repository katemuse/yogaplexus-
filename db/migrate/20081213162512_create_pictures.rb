class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.integer :width
      t.integer :height
      t.string :name
      t.references :asana, :user_observation, :user   
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end

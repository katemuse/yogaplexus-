class CreateAsanaTypes < ActiveRecord::Migration
  def self.up
    create_table :asana_types do |t|
      t.string :name
      t.text :description
    
      t.timestamps
    end
  end

  def self.down
    drop_table :asana_types
  end
end

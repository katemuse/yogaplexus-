class CreateAsanaSubtypes < ActiveRecord::Migration
  def self.up
    create_table :asana_subtypes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :asana_subtypes
  end
end

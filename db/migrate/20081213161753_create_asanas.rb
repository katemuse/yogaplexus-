class CreateAsanas < ActiveRecord::Migration
  def self.up
    create_table :asanas do |t|
      t.string :sanskrit
      t.string :english
      t.text :basic_instruction
      t.references :asana_subtype    
      t.references :asana_type
      t.timestamps
    end
  end

  def self.down
    drop_table :asanas
  end
end

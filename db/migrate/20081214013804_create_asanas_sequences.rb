class CreateAsanasSequences < ActiveRecord::Migration
  def self.up    
    create_table :asanas_sequences do |t|  
      t.references :asana, :sequence

      t.timestamps   
    end
  end

  def self.down  
    drop_table :asanas_sequences
  end
end

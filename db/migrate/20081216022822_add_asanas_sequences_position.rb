class AddAsanasSequencesPosition < ActiveRecord::Migration
  def self.up   
        add_column :asanas_sequences, :position, :integer     
  end

  def self.down 
        remove_column :asanas_sequences, :position      
  end
end

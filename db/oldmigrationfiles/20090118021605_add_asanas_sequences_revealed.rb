class AddAsanasSequencesRevealed < ActiveRecord::Migration
  def self.up 
    add_column :asanas_sequences, :revealed, :boolean
  end

  def self.down 
    remove_column :asanas_sequences, :revealed
  end
end

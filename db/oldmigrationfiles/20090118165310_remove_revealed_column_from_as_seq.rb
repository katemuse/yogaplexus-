class RemoveRevealedColumnFromAsSeq < ActiveRecord::Migration
  def self.up  
     remove_column :asanas_sequences, :revealed     
  end

  def self.down    
    add_column :asanas_sequences, :revealed, :boolean         
  end
end

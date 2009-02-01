class AddRevealedValueToAsanasSequences < ActiveRecord::Migration
  def self.up   
    AsanasSequences.find(:all).each {|pose| pose.revealed = false; pose.save}
  end

  def self.down  
    AsanasSequences.find(:all).each {|pose| pose.revealed = nil; pose.save}               
  end
end

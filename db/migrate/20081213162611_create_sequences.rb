class CreateSequences < ActiveRecord::Migration
  def self.up
    create_table :sequences do |t|  
      t.references :user, :null=> false

      t.timestamps
    end
  end

  def self.down
    drop_table :sequences
  end
end

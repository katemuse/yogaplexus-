class CreateUserObservations < ActiveRecord::Migration
  def self.up
    create_table :user_observations do |t|
      t.text :comment
      t.string :title 
      t.references :user, :asana

      t.timestamps
    end
  end

  def self.down
    drop_table :user_observations
  end
end

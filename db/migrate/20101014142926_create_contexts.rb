class CreateContexts < ActiveRecord::Migration
  def self.up
    create_table :contexts do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :contexts
  end
end

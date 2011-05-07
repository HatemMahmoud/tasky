class CreateContexts < ActiveRecord::Migration
  def self.up
    create_table :contexts do |t|
      t.references :user
      t.string :name

      t.timestamps
    end
    add_column :tasks, :context_id, :integer
  end

  def self.down
    remove_column :tasks, :context_id
    drop_table :contexts
  end
end

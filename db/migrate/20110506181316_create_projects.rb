class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.references :user
      t.string :name
      t.integer :tasks_count, :default => 0

      t.timestamps
    end
    add_column :tasks, :project_id, :integer
  end

  def self.down
    remove_column :tasks, :project_id
    drop_table :projects
  end
end

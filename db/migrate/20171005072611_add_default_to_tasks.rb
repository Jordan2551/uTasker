class AddDefaultToTasks < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :task_type, :integer, :default => 0
  end
end

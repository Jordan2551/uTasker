class RmTaskStatus < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :task_status, :integer
  end
end

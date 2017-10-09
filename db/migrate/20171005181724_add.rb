class Add < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :is_priority, :boolean, default: false
    change_column :tasks, :is_completed, :boolean, default: false
  end
end

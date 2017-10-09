class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :is_completed
      t.text :task_status

      t.timestamps
    end
  end
end

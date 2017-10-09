class AddIsAssignmentToTask < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :is_assignment, :boolean
    add_column :tasks, :is_exam, :boolean
    add_column :tasks, :is_quiz, :boolean
  end
end

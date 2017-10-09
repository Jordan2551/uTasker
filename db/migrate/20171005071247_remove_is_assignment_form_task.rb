class RemoveIsAssignmentFormTask < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :is_assignment, :boolean
    remove_column :tasks, :is_exam, :boolean
    remove_column :tasks, :is_quiz, :boolean

  end
end

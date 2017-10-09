class RemoveTaskFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_reference :users, :task, foreign_key: true
  end
end

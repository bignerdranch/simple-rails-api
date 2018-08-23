class SetDefaultTodoCompletedToFalse < ActiveRecord::Migration[5.2]
  def change
    change_column_default :todos, :complete, from: nil, to: false
  end
end

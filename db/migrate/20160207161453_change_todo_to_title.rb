class ChangeTodoToTitle < ActiveRecord::Migration
  def change
    rename_column :todos, :todo, :title
  end
end

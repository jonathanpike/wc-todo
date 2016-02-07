class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :todo 
      t.integer :session_user_id
      t.boolean :completed, default: false 
      t.timestamps null: false
    end
  end
end

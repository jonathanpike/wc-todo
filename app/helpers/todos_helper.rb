module TodosHelper
  def is_checked?(todo)
    return "checked" if todo.completed? 
  end 
end

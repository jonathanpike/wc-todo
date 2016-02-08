module TodosHelper
  def checked?(todo)
    return "checked" if todo.completed?
  end
end

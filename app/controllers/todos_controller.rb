class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end 

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render 'index'
    else 
      render 'new'
    end 
  end 

  def edit
  end

  def update
  end 

  def destroy
  end

  private

  def todo_params
    params.require(:todo).permit(:todo)
  end
end

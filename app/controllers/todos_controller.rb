class TodosController < ApplicationController
  def index
    @todos = Todo.where(session_user_id: session_user).order(created_at: :asc)
    @session_user_id = session_user
  end 

  def create
    @todo = Todo.new(todo_params)
    unless @todo.save
      flash[:alert] = "Something went wrong. Please try again."
    end
    respond_to do |format|
      format.js 
    end
  end

  def update
    @todo = Todo.find(params[:id])
    if params[:completed] || params[:id]
      @todo.toggle(:completed).save
      redirect_to root_path, status: 303
    else 
      @todo.update_attributes(todo_params)
      respond_to do |format|
        format.json { respond_with_bip(@todo) }
      end
    end    
  end 

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to root_path, status: 303
  end

  def all_complete
    @todo = Todo.where(session_user_id: session_user)
    @todo.each do |todo|
      todo.update_attribute(:completed, true)
    end
    redirect_to root_path
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :session_user_id)
  end

  def session_user
    @session_user ||= session[:user_id] || generate_session_user_id
  end

  def generate_session_user_id
    session[:user_id] = SecureRandom.hex
  end
end

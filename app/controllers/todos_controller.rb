class TodosController < ApplicationController
  respond_to :js, :html, :json
  before_action :find_all
  
  def index
    @todos = Todo.where(session_user_id: session_user).order(created_at: :asc)
    @session_user_id = session_user
  end

  def create
    @todo = Todo.new(todo_params)
    flash[:alert] = "Something went wrong. Please try again." unless @todo.save
    respond_with @todo
  end

  def update
    @todo = Todo.find(params[:id])
    if params[:completed] || params[:id]
      @todo.toggle(:completed).save
      respond_with @todo
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
    respond_with @todo
  end

  def all_complete
    @todo = Todo.where(session_user_id: session_user)
    @todo.each do |todo|
      todo.update_attribute(:completed, true)
    end
    respond_with @todo
  end

  def clear_complete
    @todo = Todo.where("session_user_id = ? AND completed = ?", session_user.to_i, true)
    @todo.each(&:destroy)
    respond_with @todo
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
  
  def find_all
    @todos = Todo.where(session_user_id: session_user).order(created_at: :asc)
  end
end

class TodosController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:index, :show]

  def index
    render json: Todo.all
  end

  def show
    render json: Todo.find(params[:id])
  end

  def create
    todo = current_user.todos.new(todo_params)
    if todo.save
      render json: todo, status: :created
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  def update
    todo = Todo.find(params[:id])
    if todo.user != current_user
      head :unauthorized
      return
    end
    if todo.update(todo_params)
      render json: todo
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    if todo.user != current_user
      head :unauthorized
      return
    end
    todo.destroy
  end

  private

  def todo_params
    params.permit(:title, :complete)
  end
end

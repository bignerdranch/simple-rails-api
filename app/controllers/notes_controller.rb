class NotesController < ApplicationController
  # before_action :doorkeeper_authorize!, except: [:index, :show]

  def index
    render json: todo.notes
  end

  def show
    render json: todo.notes.find(params[:id])
  end

  def create
    note = todo.notes.create(note_params)
    if note.save
      render json: note, status: :created
    else
      render json: note.errors, status: :unprocessable_entity
    end
  end

  def update
    note = todo.notes.find(params[:id])
    if note.update_attributes(note_params)
      render json: note
    else
      render json: note.errors, status: :unprocessable_entity
    end
  end

  def destroy
    note = todo.notes.find(params[:id])
    note.destroy
  end

  private

  def todo
    Todo.find(params[:todo_id])
  end

  def note_params
    params.permit(:body)
  end
end

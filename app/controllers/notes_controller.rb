class NotesController < ApplicationController
  # before_action :doorkeeper_authorize!, except: [:index, :show]

  def index
    render json: notes
  end

  def show
    render json: notes.find(params[:id])
  end

  def create
    note = notes.create(note_params)
    if note.save
      render json: note, status: :created
    else
      render json: note.errors, status: :unprocessable_entity
    end
  end

  def update
    note = notes.find(params[:id])
    if note.update_attributes(note_params)
      render json: note
    else
      render json: note.errors, status: :unprocessable_entity
    end
  end

  def destroy
    note = notes.find(params[:id])
    note.destroy
  end

  private

  def todo
    Todo.find(params[:todo_id])
  end

  def notes
    if todo.user == current_user
      todo.notes
    else
      []
    end
  end

  def note_params
    params.permit(:body)
  end
end

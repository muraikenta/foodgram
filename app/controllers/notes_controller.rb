class NotesController < ApplicationController
  def index
    @notes = Note.all.order(created_at: :desc)
  end

  def show
    @note = Note.find_by(id: params[:id])
  end

  def new
  end

  def create
    @note = Note.new(title: params[:title], content: params[:content])
    @note.save
    redirect_to "/notes/#{@note.id}"
  end

  def edit
    @note = Note.find_by(id: params[:id])
  end

  def update
    @note = Note.find_by(id: params[:id])
    @note.title = params[:title]
    @note.content = params[:content]
    @note.save
    redirect_to "/notes/#{@note.id}"
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    @note.destroy
    redirect_to '/notes/index'
  end
end

class NotesController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @current_user = User.find_by(id: session[:user_id])
    @notes = Note.all.order(created_at: :desc)
  end

  def show
    @note = Note.find_by(id: params[:id])
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(title: params[:title], content: params[:content])
    file = params[:image]
    if file
      @note.image = "/note_images/#{SecureRandom.urlsafe_base64}"
      File.binwrite("public/#{@note.image}", file.read)
    end

    if @note.save
      flash[:notice] = '投稿を作成しました'
      redirect_to "/notes/#{@note.id}"
    else
      render 'new'
    end
  end

  def edit
    @note = Note.find_by(id: params[:id])
  end

  def update
    @note = Note.find_by(id: params[:id])
    @note.title = params[:title]
    @note.content = params[:content]

    file = params[:image]
    if file
      @note.image = "/note_images/#{SecureRandom.urlsafe_base64}"
      File.binwrite("public/#{@note.image}", file.read)
    end

    if @note.save
      flash[:notice] = '投稿を編集しました'
      redirect_to "/notes/#{@note.id}"
    else
      render 'edit'
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    @note.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to '/notes/index'
  end
end

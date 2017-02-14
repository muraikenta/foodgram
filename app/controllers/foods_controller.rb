class FoodsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @current_user = User.find_by(id: session[:user_id])
    @foods = Food.all.order(created_at: :desc)
  end

  def show
    @food = Food.find_by(id: params[:id])
    @user = @food.user
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(title: params[:title], content: params[:content], user_id: @current_user.id)
    file = params[:image]
    if file
      @food.image = "/food_images/#{SecureRandom.urlsafe_base64}"
      File.binwrite("public/#{@food.image}", file.read)
    end

    if @food.save
      flash[:notice] = '投稿を作成しました'
      redirect_to "/foods/#{@food.id}"
    else
      render 'new'
    end
  end

  def edit
    @food = Food.find_by(id: params[:id])
  end

  def update
    @food = Food.find_by(id: params[:id])
    @food.title = params[:title]
    @food.content = params[:content]

    file = params[:image]
    if file
      @food.image = "/food_images/#{SecureRandom.urlsafe_base64}"
      File.binwrite("public/#{@food.image}", file.read)
    end

    if @food.save
      flash[:notice] = '投稿を編集しました'
      redirect_to "/foods/#{@food.id}"
    else
      render 'edit'
    end
  end

  def destroy
    @food = Food.find_by(id: params[:id])
    @food.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to '/foods/index'
  end

  private

  def ensure_correct_user
    @food = Food.find_by(id: params[:id])
    if @current_user.id != @food.user_id
      flash[:notice] = '権限がありません'
      redirect_to '/foods/index'
    end
  end
end

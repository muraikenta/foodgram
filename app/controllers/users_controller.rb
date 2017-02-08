class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:title], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ユーザー登録が完了しました'
      redirect_to "/users/#{@user.id}"
    else
      render 'new'
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to "/users/#{@user.id}"
    else
      @email = params[:email]
      @password = params[:password]
      @error_message = 'メールアドレスかパスワードに間違いがあります'
      render 'login_form'
    end
  end

  def logout
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to '/login'
  end
end

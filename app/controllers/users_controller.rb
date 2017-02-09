class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit_profile, :update_profile, :edit_password, :update_password]
  before_action :forbid_login_user, only: [:new, :create, :login_form, :login]
  
  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:title], email: params[:email], password: BCrypt::Password.create(params[:password]))
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ユーザー登録が完了しました'
      redirect_to "/users/#{@user.id}"
    else
      render 'new'
    end
  end

  def edit_profile
  end

  def update_profile
    @current_user.name = params[:name]
    @current_user.email = params[:email]
    if @current_user.save
      flash[:notice] = 'アカウント情報を編集しました'
      redirect_to "/users/#{@current_user.id}"
    else
      render 'edit_profile'
    end
  end

  def edit_password
  end

  def update_password
    if BCrypt::Password.new(@current_user.password).is_password?(params[:current_password])
      @current_user.password = BCrypt::Password.create(params[:new_password])
      @current_user.save
      flash[:notice] = 'パスワードを変更しました'
      redirect_to "/users/#{@current_user.id}"
    else
      @error_message = 'パスワードが違います'
      render 'edit_password'
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && BCrypt::Password.new(@user.password).is_password?(params[:password])
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

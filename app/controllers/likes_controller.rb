class LikesController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def index
    @user = User.find_by(id: params[:user_id])
  end

  def create
    @like = Like.new(user_id: @current_user.id, food_id: params[:food_id])
    @like.save
    flash[:notice] = 'お気に入りに登録しました'
    redirect_to "/foods/#{params[:food_id]}"
  end

  def destroy
    @like = Like.find_by(user_id: @current_user.id, food_id: params[:food_id])
    @like.destroy
    flash[:notice] = 'お気に入りから削除しました'
    redirect_to "/foods/#{params[:food_id]}"
  end
end

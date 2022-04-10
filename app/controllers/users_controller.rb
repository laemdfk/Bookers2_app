class UsersController < ApplicationController

class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]
  def correct_user
    user = User.find(params[:id])
    if current_user.id != user.id
      redirect_to user_path(current_user)
    end
  end

  def home
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: params[:id])
    @book = Book.new
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User info was successfully updated"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
# 以下、ストロングパラメータ/必ずラストのエンド前に。
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

 end
end

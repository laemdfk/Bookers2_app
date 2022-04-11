class UsersController < ApplicationController

protect_from_forgery

  def show
    #@user = User.find(params[:id])
    @books = Book.all
    @book = Book.new
  end

  def index
    @user = current_user
    @users = User.all
    @books = Book.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end


  private
# 以下、ストロングパラメータ/必ずラストのエンド前に。
  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
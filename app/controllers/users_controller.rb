class UsersController < ApplicationController
before_action :configure_permitted_parameters, if: :devise_controller?

protect_from_forgery

  def show
    #@user = User.find(params[:id])
    @books = Book.all
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
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

 def book_params
        params.require(:book).permit(:title, :body)
    end

  def user_params
    params.require(:user).permit(:name, :introduction ,:user_id)
  end
end
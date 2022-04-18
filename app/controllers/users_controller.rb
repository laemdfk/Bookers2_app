class UsersController < ApplicationController

# ActionController::InvalidAuthenticityTokenの予防用コード
protect_from_forgery

  def show
  # @user = User.find(params[:id])
    @books = Book.all
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    # @books = Book.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to book_path(current_user)
    else
      render :edit
    end
  end


  private
# 以下、ストロングパラメータ/必ずラストのエンド前に。

  def user_params
    params.require(:user).permit(:name, :introduction, :user_id, :profile_image)
  end
end
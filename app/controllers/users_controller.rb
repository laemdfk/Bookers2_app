class UsersController < ApplicationController

# ActionController::InvalidAuthenticityTokenの予防用コード
# protect_from_forgery

skip_before_action :verify_authenticity_token
#ActionController::InvalidAuthenticityToken Error対策


  def show
  # @book = Book.find(params[:id])
    # @books = Book.all
     @new_book = Book.new
     @user = User.find(params[:id])
     @books = @user.books
     #↑自分が投稿したものだけを表示させるための制御文。
     #アソシエーションで定義させている
  end

  def index
    @users = User.all
    @user = current_user
    @books = Book.all
    @new_book = Book.new
  end

  def edit #テスト的には、こっちで制御してほしい？→view側の制御も残す。
    @user = User.find(params[:id])
    if @user == current_user
          render "edit"
    else
        redirect_to user_path(current_user)
    end
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
    params.require(:user).permit(:name, :introduction, :profile_image)
    #user_id 元々勝手に入ってくれる。記述しなくて問題なし
  end
end
class BooksController < ApplicationController

# ActionController::InvalidAuthenticityToken Errorの予防用コード(CSRF対策).→プロテクトによりidが参照できなくなるので、以下追記。
# protect_from_forgery

skip_before_action :verify_authenticity_token
#ActionController::InvalidAuthenticityToken Error対策

#   before_action :authenticate_user!
  #deviseのメソッド。ユーザがログインしているかどうかを確認し、ログインしていない場合はユーザをログインページにリダイレクトする処理

  before_action :current_user, {only: [:edit, :update, :destroy]}
     #ログインユーザー以外では、上記のアクションを実行できなくする処理



	def create
    #  current_user→現在のユーザーの意
        @user = current_user
		@new_book = Book.new(book_params)

        @new_book.user_id = current_user.id
        #↑ ユーザーと投稿を紐づけるためのコード

	    if @new_book.save
        flash[:notice] = "You have creatad book successfully."
		    redirect_to  book_path(@new_book.id)

       else
        @books = Book.all
        render "index"
      end
	end


    def show
    @new_book = Book.new #editページを除き、新規投稿フォームがあるため
    @book = Book.find(params[:id])
    # @books = Book.all
    @user = @book.user
# 　  @users = User.find(params[:id])
    end


    def index
        @user = current_user
        @books = Book.all
        @new_book = Book.new
        # @book = Book.find(params[:id])
    end

     #もし「現在のユーザであれば」editページへ遷移させる
   def edit
     @book = Book.find(params[:id])
    if @book.user == current_user
         render "edit"
    else
        redirect_to books_path
    end
  end


    def update
        @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have updated successfully."
      redirect_to book_path(@book.id)

    else
        # @books = Book.all
        render "edit"
        end
    end


    def destroy
      book = Book.find(params[:id])
      book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end


	private

    def book_params
        params.require(:book).permit(:title, :body)
    end

     def authenticate_current_user
        @book = Book.find(params[:id])
        if @book.user_id != current_user
         redirect_to books_path
      end
    end

     def user_params
         params.require(:user).permit(:name, :introduction, :user_id, :profile_image_id)
     end

 end

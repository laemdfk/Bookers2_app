class BooksController < ApplicationController

# ActionController::InvalidAuthenticityToken Errorの予防用コード(CSRF対策).→プロテクトによりidが参照できなくなるので、以下追記。
# protect_from_forgery

skip_before_action :verify_authenticity_token
#ActionController::InvalidAuthenticityToken Error対策

#   before_action :authenticate_user!
  #deviseのメソッド。ユーザがログインしているかどうかを確認し、ログインしていない場合はユーザをログインページにリダイレクトする処理

  before_action :current_user, {only: [:update, :destroy]}
     #ログインユーザー以外では、上記のアクションを実行できなくする処理



	def create
    #  current_user→現在のユーザーの意
        @user = current_user
		    @book = Book.new(book_params)

        @book.user_id = current_user.id
        #↑ ユーザーと投稿を紐づけるためのコード

	    if @book.save
        flash[:notice] = "You have creatad book successfully."
		    redirect_to  book_path(@book.id)

       else
        @books = Book.all
        flash[:notice] = 'errors prohibited this obj from being saved'
        render "index"
      end
	end


    def show
    @book_new = Book.new #editページを除き、新規投稿フォームがあるため
    @book = Book.find(params[:id])
    @books = Book.all
    @user = current_user
    #  @users = User.where(user_id: current_user.id).includes(:user).order("created_at DESC")
    end


    def index
        @user = current_user
        @books = Book.all
        @book = Book.new
    end

     #もし「現在のユーザであれば」editページへ遷移させる
   def edit
     @book = Book.find(params[:id])
    # if @book.user == current_user
    #      render "edit"
    # else
    #     redirect_to books_path
    # end
  end


    def update
        @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have updated successfully."
      redirect_to book_path(@book.id)

    else
        # @books = Book.all
         flash[:notice]= 'errors prohibited this obj from being saved:'
        render "edit"
        end
    end


    def destroy
      book = Book.find(params[:id])
      book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    #   else
    #     flash[:notice]="sorry, I couldn't delete your post."
    #     render book_path
    #  end
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

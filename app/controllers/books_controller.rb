class BooksController < ApplicationController

# ActionController::InvalidAuthenticityTokenの予防用コード
protect_from_forgery

  # before_action :authenticate_user!
  #deviseのメソッド。ユーザがログインしているかどうかを確認し、ログインしていない場合はユーザをログインページにリダイレクトする処理
  
  before_action :authenticate_current_user, {only: [:edit, :update, :destroy]}
     #ログインユーザー以外では、上記のアクションを実行できなくする処理
     

	def create
#  user = current_userとする
		@book = Book.new(book_params)
        @book.user_id = current_user.id
	    if @book.save
        flash[:notice] = "You have creatad book successfully."
		redirect_to  book_path(@book.id)

        else
        @books = Book.all
        flash[:notice] = ' errors prohibited this obj from being saved:'
        render "index"
     end
	end

    def show
    @books = Book.all
    @user = current_user
    #@book = Book.find(params[:id])
    @book_new = Book.new
    end

    def index
        @user = current_user
        @books = Book.all
        @book = Book.new
    end
    
    #updateで処理したい→edit側の記述コメントアウト
    def edit
    #  @user = current_user
     @book = Book.find(params[:id])
    # if @book.save == current_user
    #       flash[:notice] = "You have edited book successfully."
    #       redirect_to books_path
    # else
    #   render "edit"
    # end
  end


    def update
        @book =Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have updated user successfully."
      redirect_to users_path(current_user)

    else
        # @books = Book.all
         flash[:notice]= ' errors prohibited this obj from being saved:'
        render "edit"
        end
    end

    def destroy
      @book = Book.find(params[:id])
      if @book.destroy
       flash[:notice]="Book was successfully destroyed."
      redirect_to book_path
     end
    end

	private

    def book_params
        params.require(:book).permit(:title, :body)
    end

     def user_params
         params.require(:user).permit(:name, :introduction, :user_id, :profile_image_id)
     end
 

    def authenticate_current_user
      @book = Book.find(params[:id])
      if @book.user_id != current_user
        redirect_to books_path
      end
    end
 end

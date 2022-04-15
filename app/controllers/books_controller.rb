class BooksController < ApplicationController

# ActionController::InvalidAuthenticityTokenの予防用コード
protect_from_forgery


 before_action :authenticate_user!
     before_action :ensure_current_user, {only: [:edit,:update,:destroy]}
     #ログインユーザー以外の遷移を防止する

	def create
        #@user = current_user
		@book = Book.new(book_params)
        @book.user_id = (current_user.id)
	    if @book.save
		redirect_to user_path(@book.id)
        # redirect_to "/books/#{@book.id}"

        else
        @books = Book.all
        flash[:notice] = ' errors prohibited this obj from being saved:'
        render "index"
        end
	end

    def show
        @user = current_user
    # 	@book = Book.find(params[:id])
    	  @book_new = Book.new
    end

    def index
        @user = current_user
        @books = Book.all
        @book = Book.new
    end

    def edit
    	@book = Book.find(params[:id])
    end


    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
        flash[:notice] = "You have creatad book successfully."
        redirect_to  book_path(@book.id)

        else
        @books = Book.all
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
        params.require(:user).permit(:name,:profile_image,:introduction)
   end

     def  ensure_current_user
      @book = Book.find(params[:id])
       if @book.user_id != current_user.id
        redirect_to books_path
     end
    end
  end


class BooksController < ApplicationController

# ActionController::InvalidAuthenticityTokenの予防用コード
protect_from_forgery


before_action :corrent_user, only: [:edit, :destroy]

 def index
  @books = Book.all
  @book = Book.new
 end

 def create
   @book = Book.new(book_params)
    #@book.user_id = current_user.id
  if @book.save
   redirect_to books_path(@book.id)

  else
   @books = Book.all
    render  'index'
  end
 end

 def show
  @book = Book.find(params[:id])
 end

 def edit
 @book = Book.find(params[:id])
 end

 def updete
   @book = Book.find(params[:id])
     if @book.update(book_params)
      flash[:notice] = "Book was successfully update."
     redirect_to book_path(book.id)
     else
     @books = Book.all
      render 'edit'
    end
 end

 def destroy
     @book = Book.find(params[:id])
     @book.destroy
     flash[:notice]="Book was successfully destroyed."
     redirect_to books_path
 end


# 以下、ストロングパラメータ/必ずラストのエンド前に。
private
 def book_params
  params.require(:book).permit(:title, :body)
 end

  def corrent_user
 @book = Book.find(params[:id])
 @user = @book_user
  redirect_to(books_path) unless @user==current_user
  end
end
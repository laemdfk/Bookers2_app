class BooksController < ApplicationController


  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def index
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
   @book = Book.new(book_params)
   @book.save
    redirect_to book_path(@book),notice: "You have created book successfully."
  end

  def create
    	@book = Book.new(book_params)
	    @book.save
		  redirect_to  book_path(@book.id)
  end

  def update
     @book = Book.find(params[:id])
     book.update(book_params)
     redirect_to  book_path(@book.id)
  end

  def destroy
  end


private
    def book_params
      params.require(:book).permit(:title, :body)
    end


end

class BooksController < ApplicationController
  def new
    @book=Book.new
  end

 # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end
  
  def index
    @books = Book.all
    # @user = current_user.id
  end
  
  def destroy
    @book = Book.find(book_params)
    book.destroy
    redirect_to books_path(book)
  end

  def show
    @book = Book.find(params[:id])
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
end

class BooksController < ApplicationController
  def new
    @book=Book.new
  end

 # 投稿データの保存
  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if  @book.save
      flash[:notice] = "You have created book successfully." 
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end
  
  def index
    @books = Book.all
    @book =Book.new
    @user = current_user
  end
  
  def edit
    @books = Book.all
    @book = Book.find(params[:id])
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
 
    
  def update
    @books = Book.all
    @book = Book.find(params[:id])
    
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully." 
      redirect_to book_path(@book.id) 
    else
      flash.now[:alert]
      render :edit
    end
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
end

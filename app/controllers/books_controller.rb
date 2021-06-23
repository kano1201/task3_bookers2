class BooksController < ApplicationController

  def create
    @books = Book.page(params[:page]).reverse_order
    @user = User.find(current_user.id)
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index

      #partial: 'layouts/list'
    end
  end

  def index
    @books = Book.page(params[:page]).reverse_order
    @book = Book.new
    @user = current_user
  end

  def show
    @books = Book.find(params[:id])
    @user = @books.user
    
    @book = Book.new
  end

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
      flash[:notice] = "You have updated book successfully."
     redirect_to book_path(@book.id)
    else
     render :edit
    end

  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end
  
  def create
    @book = Book.new(list_params)
    if @book.save
      flash[:notice] = "#{@book.title} was successfully created."
      redirect_to book_path(@book.id)
    else
      # validation error => Error Msg
      @books = Book.all
      render :index
    end
  end
  
  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(list_params)
      flash[:notice] = "#{@book.title} was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = "#{book.title} was successfully deleted."
    else
      flash[:error] = "失敗時メッセージ"
    end
    redirect_to books_path
  end
  
  private
  # ストロングパラメータ
  def list_params
    params.require(:book).permit(:title, :body)
  end
  
end

# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.order(:id)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @count = Book.count
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: 'Successfully created a book'
    else
      flash[:notice] = "Failed to create a book, title can't be blank."
      render('new')
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Successfully updated a book'
    else
      render('edit')
    end
  end

  def delete
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: 'Successfully deleted a book'
  end

  private

  def book_params
    params.require(:book).permit(
      :title,
      :author,
      :price,
      :published_date
    )
  end
end


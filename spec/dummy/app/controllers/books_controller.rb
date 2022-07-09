# frozen_string_literal: true

class BooksController < ApplicationController
  include HotwireDatatables::Controller

  def index
    books = Book.all
    @books_table = BooksTable.new(request, books)
  end

  def mark_read
    book = Book.find(params[:id])
    book.update_attribute(:status, 'read')

    render turbo_stream: table_turbo_stream(BooksTable).update(book)
  end

  def unmark_read
    book = Book.find(params[:id])
    book.update_attribute(:status, 'unread')

    # TODO: check graceful JS-less downgrade
    render turbo_stream: table_turbo_stream(BooksTable).update(book)
  end
end

# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    books = Book.all
    @books_table = BooksTable.new(request, books)
  end
end

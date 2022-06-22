# frozen_string_literal: true

# A simple table with a list of books
class BooksTable < HotwireDatatables::Table
  # pagination_adapter :pagy

  column :title
end

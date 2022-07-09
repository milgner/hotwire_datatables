# frozen_string_literal: true

class BooksTable < HotwireDatatables::Table
  # The base query is supplied by the controller
  # and is enhanced here for suitability to the needs of the table
  query ->(records, _params) do
    records.joins(:authors) # for sorting
           .includes(:authors) # for quick access when rendering author names
           .distinct
  end

  column :title do
    sortable
  end

  column :author_names do
    sortable
    sort_expression 'authors.name'
    format_with { |book| book.authors.pluck(:name).join(', ') }
  end

  column :actions do
    # If the model supports `ActiveModel::Naming`, the renderer can assign a variable
    # with a proper name. In this instance, the variable will be called `@book`.
    # Otherwise it will just be called `@row`
    virtual partial: 'books/row_actions'
  end
end

# frozen_string_literal: true

class BooksTable < HotwireDatatables::Table
  # The base query is supplied by the controller
  # and is enhanced here for suitability to the needs of the table
  query ->(records, _params) do
    records.joins(:authors) # for sorting
           .includes(:authors)
           .distinct
  end

  column :title do
    sortable
  end

  column :author_names do
    sortable
    sort_expression 'authors.name'
    value { |book| book.authors.pluck(:name).join(', ') }
  end
end

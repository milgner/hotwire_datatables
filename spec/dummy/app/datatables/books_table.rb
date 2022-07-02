# frozen_string_literal: true

class BooksTable < HotwireDatatables::Table
  column :title do
    sortable
  end

  query ->(records, _params) do
    records.joins(:authors)
           .includes(:authors)
  end

  column :author_names do
    sortable
    sort_expression 'authors.name'
    value { |book| book.authors.pluck(:name).join(', ') }
  end
end

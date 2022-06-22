# frozen_string_literal: true

require_relative "./column"
require_relative "./dsl/column"

module HotwireDatatables
  class Table
    include ColumnDsl
  end
end

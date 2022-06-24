# frozen_string_literal: true

module HotwireDatatables
  # A record, in the context of a table, we call a row :)
  class Row
    attr_reader :record, :table

    def initialize(table, record)
      @table = table
      @record = record
    end

    def cells
      @cells ||= table.columns.map do |column|
        Cell.new(column, self)
      end
    end
  end
end

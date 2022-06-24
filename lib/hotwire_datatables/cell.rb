# frozen_string_literal: true

module HotwireDatatables
  # The contents of a column in the context of a row
  class Cell
    attr_reader :row, :column

    delegate :record, to: :row

    def initialize(column, row)
      @column = column
      @row = row
    end

    def to_html
      # TOOD: needs a mechanism to format values & customize rendering
      record.public_send(column.name)
    end
  end
end

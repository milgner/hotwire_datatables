# frozen_string_literal: true

module HotwireDatatables
  # Models the column
  class Column
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end

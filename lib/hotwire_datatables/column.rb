# frozen_string_literal: true

module HotwireDatatables
  # Models the column
  class Column
    attr_reader :name
    attr_writer :title

    def initialize(name)
      @name = name
    end

    def title
      @title || name.to_s.titleize
    end
  end
end

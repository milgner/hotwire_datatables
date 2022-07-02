# frozen_string_literal: true

module HotwireDatatables
  # Models the column
  class Column
    attr_reader :name
    attr_writer :title, :sort_expression, :display_with
    attr_accessor :sortable

    def initialize(name)
      @name = name
      @sortable = false # seems safer for now
    end

    def title
      @title || name.to_s.titleize
    end

    def sort_expression
      @sort_expression || name
    end

    def sortable?
      !!sortable
    end

    def value(record)
      return record.public_send(name) if @display_with.blank?

      @display_with[record]
    end
  end
end

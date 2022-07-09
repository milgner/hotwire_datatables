# frozen_string_literal: true

module HotwireDatatables
  # Models the column definition
  # TODO: separate column definition and instance
  class ColumnDefinition
    attr_reader :name
    attr_writer :title, :sort_expression, :format_with
    attr_accessor :sortable, :virtual, :cell_renderer

    def initialize(name)
      @name = name
      @sortable = false # seems safer for now
      @virtual = false
    end

    def title
      @title || name.to_s.titleize
    end

    def sort_expression
      @sort_expression || name
    end

    def sortable?
      !!sortable && !virtual? # don't support sorting virtual columns for now
    end

    def virtual?
      !!virtual
    end

    def format_value(record)
      return @format_with.call(record) if @format_with.present?
      return if virtual?

      record.public_send(name)
    end
  end
end

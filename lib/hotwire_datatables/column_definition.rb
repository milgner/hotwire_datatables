# frozen_string_literal: true

module HotwireDatatables
  # Models the column definition
  class ColumnDefinition
    attr_reader :name
    attr_writer :title, :source_expression, :format_with
    attr_accessor :sortable, :virtual, :cell_renderer

    def initialize(name)
      @name = name
      @sortable = false # seems safer for now
      @virtual = false
    end

    def title
      @title || name.to_s.titleize
    end

    # Used for sorting & filtering, will be interpreted by the query adapter & filtering
    def source_expression
      @source_expression || name
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

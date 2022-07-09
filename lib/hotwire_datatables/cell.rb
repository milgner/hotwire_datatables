# frozen_string_literal: true

module HotwireDatatables
  # The contents of a column in the context of a row
  class Cell
    attr_reader :row, :column_definition

    delegate :record, to: :row

    # @param column_definition [HotwireDatatables::ColumnDefinition]
    # @param row [HotwireDatatables::Row]
    def initialize(column_definition, row)
      @column_definition = column_definition
      @row = row
    end

    def dom_id
      "#{row.dom_id}_#{column_definition.name}"
    end

    def render_in(view_context, &block)
      value = column_definition.format_value(record)
      view_context.assign({ assigns_variable_name => record })
      column_definition.cell_renderer.render(view_context, :value, value, &block)
    end

    def assigns_variable_name
      return record.model_name.singular if record.respond_to?(:model_name)

      'row'
    end
  end
end

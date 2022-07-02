# frozen_string_literal: true

module HotwireDatatables
  # DSL to define columns
  module ColumnDsl
    extend ActiveSupport::Concern

    # Contains the DSL methods for the column configuration block
    class ConfigBlock
      attr_reader :column

      def initialize(column_name)
        @column = Column.new(column_name)
      end

      def title(title)
        column.title = title
      end

      def sortable(is_sortable = true)
        column.sortable = is_sortable
      end

      def sort_expression(expression)
        column.sort_expression = expression.presence
      end

      def value(proc = nil, &block)
        raise ArgumentError unless proc.present? || block_given?
        proc ||= block.to_proc
        raise ArgumentError, "Proc needs 1 argument only" unless proc.parameters.length == 1
        column.display_with = proc
      end
    end

    class_methods do
      attr_reader :columns

      def column(column_name, &block)
        @columns ||= []
        config = ConfigBlock.new(column_name)
        config.instance_eval(&block) if block_given?
        columns << config.column
      end
    end

    delegate :columns, to: :class
  end
end

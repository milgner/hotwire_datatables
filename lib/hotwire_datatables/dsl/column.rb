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
        @column.title = title
      end
    end

    class_methods do
      attr_reader :columns

      def column(column_name, &block)
        @columns ||= []
        config = ConfigBlock.new(column_name)
        config.instance_eval(&block) if block_given?
        @columns << config.column
      end
    end

    delegate :columns, to: :class
  end
end

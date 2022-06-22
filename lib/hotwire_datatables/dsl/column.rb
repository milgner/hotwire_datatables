# frozen_string_literal: true

module HotwireDatatables
  # DSL to define columns
  module ColumnDsl
    extend ActiveSupport::Concern

    class_methods do
      attr_reader :columns

      def column(column_name)
        @columns ||= []
        @columns << Column.new(column_name)
      end
    end
  end
end

# frozen_string_literal: true

module HotwireDatatables
  # DSL to define columns
  module ColumnDsl
    extend ActiveSupport::Concern

    # Contains the DSL methods for the column configuration block
    class ConfigBlock
      attr_reader :column_definition

      RENDERER_KEYS = {
        partial: Rendering::PartialRenderer,
        view_component: Rendering::ViewComponentRenderer
      }.freeze

      def initialize(column_name)
        @column_definition = ColumnDefinition.new(column_name)
      end

      def title(title)
        column_definition.title = title
      end

      def sortable(is_sortable = true)
        column_definition.sortable = is_sortable
      end

      def sort_expression(expression)
        column_definition.sort_expression = expression.presence
      end

      def virtual(**render_args)
        column_definition.virtual = true
        render_with(**render_args)
      end

      def render_with(**render_args)
        arg_key, arg_value = render_args.find { |k, _v| RENDERER_KEYS.key?(k) }
        raise ArgumentError, "Unsupported render expression: #{render_args}" if arg_key.nil?

        column_definition.cell_renderer = RENDERER_KEYS[arg_key].new(arg_value)
      end

      def format_with(proc = nil, &block)
        raise ArgumentError unless proc.present? || block_given?
        proc ||= block.to_proc
        raise ArgumentError, "Proc needs 1 argument only" unless proc.parameters.length == 1
        column_definition.format_with = proc
      end

      def build
        # Unfortunately, there is no built-in identity function in Ruby 😿
        column_definition.cell_renderer ||= Rendering::LambdaRenderer.new(->(value) { value })
        column_definition
      end
    end

    class_methods do
      attr_reader :columns

      def column(column_name, &block)
        @columns ||= []
        config = ConfigBlock.new(column_name)
        config.instance_eval(&block) if block_given?
        columns << config.build
      end
    end

    delegate :columns, to: :class
  end
end

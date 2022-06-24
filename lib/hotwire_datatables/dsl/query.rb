# frozen_string_literal: true

module HotwireDatatables
  # DSL to define queries
  module QueryDsl
    extend ActiveSupport::Concern

    ERROR_TWO_BLOCK_ARGUMENTS_REQUIRED = "Query block must have 2 arguments: base query and params"
    ERROR_UNKNOWN_QUERY_ADAPTER_TYPE = "Unknown query adapter type"
    ERROR_UNKNOWN_PAGINATION_ADAPTER_TYPE = "Unknown pagination adapter type"

    QUERY_ADAPTERS = {
      active_record: HotwireDatatables::QueryAdapters::ActiveRecord
    }.freeze

    PAGINATION_ADAPTERS = {
      pagy: HotwireDatatables::PaginationAdapters::Pagy
    }.freeze

    PaginationAdapterOptions = Struct.new(:clazz, :block) do
      def instantiate(table)
        clazz.new(table, &block)
      end
    end

    class_methods do
      attr_reader :query_block

      def query(&block)
        return if block.nil?

        raise ArgumentError, ERROR_TWO_BLOCK_ARGUMENTS_REQUIRED unless block.parameters.length == 2

        @query_block = block
      end

      def query_adapter(type)
        raise ArgumentError, ERROR_UNKNOWN_QUERY_ADAPTER_TYPE unless QUERY_ADAPTERS.key?(type)

        @query_adapter_class = QUERY_ADAPTERS[type]
      end

      def pagination_adapter(type, &block)
        raise ArgumentError, ERROR_UNKNOWN_PAGINATION_ADAPTER_TYPE unless PAGINATION_ADAPTERS.key?(type)

        @pagination_adapter_options = PaginationAdapterOptions.new(PAGINATION_ADAPTERS[type], block)
      end

      def pagination_adapter_options
        @pagination_adapter_options || PaginationAdapterOptions.new(PAGINATION_ADAPTERS[:pagy], nil)
      end

      def query_adapter_class
        @query_adapter_class || QUERY_ADAPTERS[:active_record]
      end
    end

    def query_adapter
      @query_adapter ||= self.class.query_adapter_class.new(self)
    end

    def pagination_adapter
      @pagination_adapter ||= self.class.pagination_adapter_options.instantiate(self)
    end
  end
end

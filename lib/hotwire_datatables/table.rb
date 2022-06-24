# frozen_string_literal: true

require_relative "./column"
require_relative "./cell"
require_relative "./row"

require_relative "./dsl/column"
require_relative "./dsl/query"

module HotwireDatatables
  # Base class for all datatables. On the class level it contains the metadata/table structure
  # whereas on the instance level it is parses params to retrieve matching records which can
  # then be used to render it.
  class Table
    include ColumnDsl
    include QueryDsl

    attr_reader :params, :records

    # @param params [Hash] request params used for pagination, sorting & filtering
    # @param records scoped records injected from the controller. Will be processed via the query adapter.
    def initialize(params, records)
      super()
      @params = params
      @records = records
    end

    def rows
      @rows ||= visible_records.map do |record|
        Row.new(self, record)
      end
    end

    def pagination_context
      @pagination_context ||= pagination_adapter.apply_pagination(filtered_records)
    end

    def to_partial_path
      HotwireDatatables::PARTIALS_PATH.join("table")
    end

    private

    def visible_records
      @visible_records ||= pagination_context.records
    end

    def filtered_records
      @filtered_records ||= query_adapter.apply_filters(records)
    end
  end
end

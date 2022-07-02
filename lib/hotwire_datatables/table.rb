# frozen_string_literal: true

require_relative "./column"
require_relative "./cell"
require_relative "./row"

require_relative './presenters/column_presenter'

require_relative "./dsl/column"
require_relative "./dsl/query"

require 'active_model'

module HotwireDatatables
  # Base class for all datatables. On the class level it contains the metadata/table structure
  # whereas on the instance level it is parses params to retrieve matching records which can
  # then be used to render it.
  class Table
    include ActiveModel::Model # preliminary: we don't really need that much, should be possible to slim down

    include ColumnDsl
    include QueryDsl

    attr_reader :request, :records
    delegate :params, to: :request

    # @param request [ActionDispatch::Request] request params used for pagination, sorting & filtering
    # @param records scoped records injected from the controller. Will be processed via the query adapter.
    def initialize(request, records)
      super()
      @request = request
      @records = records
    end

    def rows
      @rows ||= visible_records.map do |record|
        Row.new(self, record)
      end
    end

    # Pagination context ties the class-level pagination adapter to this instance of the table
    def pagination_context
      @pagination_context ||= pagination_adapter.apply_pagination(request, sorted_records)
    end

    def to_partial_path
      'hotwire_datatables/table'
    end

    # The columns by which to actually sort data in order of importance:
    # the most important column comes first which means the UI will have
    # to prepend search columns
    #
    # @return [Array<[Column, Symbol]>]
    def sort_columns
      @sort_columns ||= begin
                          sortable_columns = columns&.select(&:sortable)
                          return [] if sortable_columns.blank?

                          Array(params['sort_col']).map.with_index do |column_name, idx|
                            column = sortable_columns.find { |col| col.name.to_s == column_name }
                            next if column.nil?
                            [column, params['sort_dir'][idx]]
                          end.compact.presence || [[sortable_columns.first, 'asc']]
                        end
    end

    private

    def visible_records
      @visible_records ||= pagination_context.records
    end

    def sorted_records
      @sorted_records ||= sort_columns.reduce(filtered_records) do |records, (column, direction)|
        query_adapter.apply_sorting(records, column, direction)
      end
    end

    def filtered_records
      @filtered_records ||= query_adapter.apply_filters(records, params)
    end
  end
end

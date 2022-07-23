require 'action_view'

module HotwireDatatables
  # Helper class to render the header for a given column definition
  class ColumnHeader < ActionView::Base
    attr_reader :table, :column_definition
    delegate :sortable?, to: :column_definition

    # @param table [HotwireDatatables::Table]
    # @param column_definition [HotwireDatatables::ColumnDefinition]
    # @param request [ActionDispatch::Request] used to determine the current state & build new URLs
    def initialize(table, column_definition, request)
      @table = table
      @column_definition = column_definition
      @request = request
    end

    def to_html
      tag.div class: 'dt-col-header' do
        if sortable?
          link_to sort_url do
            simple_header +
              sort_indicator
          end
        else
          simple_header
        end
      end
    end

    def to_s
      to_html
    end

    private

    # Renders the up/down arrows that indicate whether the table is currently sorted by this column
    def sort_indicator
      class_list = %w[sort].tap do |cl|
        current_sort = table.sort_columns.find { |(col, _dir)| col == column_definition }
        next unless current_sort

        cl << "sort-#{current_sort[1]}"
      end
      tag.div(class: class_list)
    end

    def params
      @params ||= @request.params.except(*@request.path_parameters.keys)
    end

    # Builds a URL that allows sorting by this column; if currently sorted by this column,
    # the new URL will sort in the other direction
    def sort_url
      uri = URI.parse(@request.original_url) # base URL on the current one and modify the sort params only
      params = self.params.deep_dup

      params[:sort_col] = sort_columns.map(&:first)
      params[:sort_dir] = sort_columns.map(&:last)

      uri.query = params.to_query
      uri.to_s
    end

    # The basic header just contains the column title
    def simple_header
      sanitize(column_definition.title)
    end

    # When visiting this URL, the current column should be the first column used
    # for sorting, so it should be prepended to any previous sorting
    def sort_columns
      @sort_columns ||=
        begin
          previous_sort, previous_sort_columns = table.sort_columns.partition { |(col, _dir)| col == column_definition }
          sort_dir = previous_sort.blank? || previous_sort[0][1] == 'desc' ? 'asc' : 'desc'
          previous_sort_columns.map { |(col, dir)| [col.name, dir] }.prepend([column_definition.name, sort_dir])
        end
    end

    def class_list
      @class_list ||= %w[dt-cell].tap { |cl| cl << 'sortable' if sortable? }
    end
  end
end

require 'action_view'

class ColumnPresenter < ActionView::Base
  attr_reader :column
  delegate :sortable?, to: :column

  # @param table [HotwireDatatables::Table]
  # @param column [HotwireDatatables::Column]
  # @param request [ActionDispatch::Request] used to build new URLs
  def initialize(table, column, request)
    @table = table
    @column = column
    @request = request
  end

  def to_html
    if sortable?
      tag.div class: 'dt-col-header' do
        link_to sort_url do
          simple_header +
            sort_indicator
        end
      end
    else
      simple_header
    end
  end

  def to_s
    to_html
  end

  private

  def sort_indicator
    class_list = %w[sort].tap do |cl|
      current_sort = @table.sort_columns.find { |(col, _dir)| col == column }
      next unless current_sort

      cl << "sort-#{current_sort[1]}"
    end
    tag.div(class: class_list)
  end

  def params
    @params ||= @request.params.except(*@request.path_parameters.keys)
  end

  # When visiting this URL, the current column should be the first column used
  # for sorting, so it should be prepended
  def sort_url
    uri = URI.parse(@request.original_url) # base URL on the current one and modify the sort params only
    params = self.params.deep_dup
    previous_sort, sort_columns = @table.sort_columns.partition { |(col, _dir)| col == column }
    sort_dir = previous_sort.blank? || previous_sort[0][1] == 'desc' ? 'asc' : 'desc'
    sort_columns = sort_columns.map { |(col, dir)| [col.name, dir] }.prepend([column.name, sort_dir])

    params[:sort_col] = sort_columns.map(&:first)
    params[:sort_dir] = sort_columns.map(&:last)

    uri.query = params.to_query
    uri.to_s
  end

  def simple_header
    tag.div column.title
  end

  def class_list
    @class_list ||= %w[dt-cell].tap { |cl| cl << 'sortable' if sortable? }
  end
end

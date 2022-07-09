# frozen_string_literal: true

module HotwireDatatables
  # A record, in the context of a table, we call a row :)
  class Row
    attr_reader :record, :table

    def initialize(table, record)
      @table = table
      @record = record
    end

    def dom_id
      helpers.dom_id(record, 'table-row')
    end

    # TOOD: rendering architecture still quite suboptimal
    def render_in(view_context, &block)
      renderer.render(view_context, :row, self, &block)
    end

    def cells
      @cells ||= table.columns.map do |column_definition|
        Cell.new(column_definition, self)
      end
    end

    private

    # TODO: refine concept, maybe declare row renderer on table?
    def renderer
      @renderer ||= Rendering::PartialRenderer.new('hotwire_datatables/row')
    end

    def helpers
      @helpers ||= Object.new.tap { |o| o.extend(ActionView::RecordIdentifier) }
    end
  end
end

module HotwireDatatables
  # Encapsulates Turbo-related functionality for tables
  class TableTurboStream
    attr_reader :table, :tag_builder, :view_context

    def initialize(table, view_context)
      @table = table
      @view_context = view_context
      @tag_builder = Turbo::Streams::TagBuilder.new(view_context)
    end

    def update(record)
      row = Row.new(table, record)
      @tag_builder.replace(row.dom_id, row.render_in(view_context))
    end
  end
end

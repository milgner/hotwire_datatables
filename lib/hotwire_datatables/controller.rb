module HotwireDatatables
  # Provides controller support for datatables: filter actions & Turbo updates
  module Controller
    extend ActiveSupport::Concern

    def table_turbo_stream(table)
      TableTurboStream.new(table, view_context)
    end
  end
end

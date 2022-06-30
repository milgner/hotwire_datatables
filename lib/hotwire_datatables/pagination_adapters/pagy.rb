# frozen_string_literal: true

require "pagy"
require "pagy/backend"
require "pagy/extras/items"

module HotwireDatatables
  module PaginationAdapters
    # Adapter for pagination via pagy
    class Pagy
      include ::Pagy::Backend
      include ::Pagy::ItemsExtra::Backend

      PaginationContext = Struct.new(:pagy, :request, :records) do
        include ::Pagy::Frontend

        def render
          pagy_nav(pagy).html_safe
        end
      end

      attr_reader :table

      def initialize(table)
        @table = table
      end

      def apply_pagination(request, records)
        pagy, records = pagy(records)
        PaginationContext.new(pagy, request, records)
      end

      # required by pagy to determine the current page
      delegate :params, to: :table
    end
  end
end

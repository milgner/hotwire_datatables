# frozen_string_literal: true

module HotwireDatatables
  module QueryAdapters
    # Used to query data using ActiveRecord
    #
    # The only responsibility of the query adapter is to process the base query,
    # apply filters and return something that can then be paginated in the pagination adapter.
    # Since we'll be using pagy and ActiveRecord, this is a very easy task for now...
    # Things will become a bit trickier once we add filters into the picture.
    class ActiveRecord
      attr_reader :table

      def initialize(table)
        @table = table
      end

      # @param base [ActiveRecord::Relation] base query as injected by the controller
      # @return [ActiveRecord::Relation] the query to retrieve the records after applying filters
      def apply_filters(base)
        block = table.class.query_block
        return base if block.nil?

        block.call(base)
      end
    end
  end
end

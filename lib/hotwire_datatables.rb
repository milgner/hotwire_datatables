# frozen_string_literal: true

require "active_support"
require "active_support/core_ext" # `delegate`, among others

require_relative "hotwire_datatables/version"

require_relative "hotwire_datatables/pagination_adapters/pagy"
require_relative "hotwire_datatables/query_adapters/active_record"

require_relative "hotwire_datatables/column"
require_relative "hotwire_datatables/row"
require_relative "hotwire_datatables/cell"
require_relative "hotwire_datatables/table"

module HotwireDatatables
  class Error < StandardError; end

  PARTIALS_PATH = Pathname.new(File.dirname(__FILE__)).join("hotwire_datatables", "views")
end

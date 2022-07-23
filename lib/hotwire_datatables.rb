# frozen_string_literal: true

require "active_support"
require "active_support/core_ext" # `delegate`, among others
require "active_support/dependencies/autoload"

require_relative "hotwire_datatables/version"

module HotwireDatatables
  PARTIALS_PATH = Pathname.new(File.dirname(__FILE__)).join("hotwire_datatables", "views")
  JAVASCRIPT_PATH = Pathname.new(File.dirname(__FILE__)).join("hotwire_datatables", "javascript")

  extend ActiveSupport::Autoload

  class Error < StandardError; end

  autoload :Cell
  autoload :Controller
  autoload :ColumnDefinition
  autoload :Row
  autoload :Table
  autoload :TableTurboStream
  autoload :Rendering
  autoload :QueryAdapters
  autoload :PaginationAdapters
end

require_relative 'hotwire_datatables/railtie'
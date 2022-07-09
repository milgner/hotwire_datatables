module HotwireDatatables
  module Rendering
    extend ActiveSupport::Autoload

    autoload :LambdaRenderer
    autoload :PartialRenderer
    autoload :ViewComponentRenderer
  end
end
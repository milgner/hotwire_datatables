# frozen_string_literal: true

module HotwireDatatables
  module Rendering
    # Renders datatable elements using view components
    # s.a. https://github.com/github/view_component
    class ViewComponentRenderer
      def initialize(component_class)
        raise ArgumentError, "Not a ViewComponent class" unless component_class.is_a?(ViewComponent::Base)
        @component_class = component_class
      end

      def render(view_context, type, value, &block)
        component = @component_class.new(type => value)
        component.render_in(view_context, &block)
      end
    end
  end
end


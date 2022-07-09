module HotwireDatatables
  module Rendering
    class PartialRenderer
      def initialize(partial)
        @partial = partial
      end

      def render(view_context, type, value, &block)
        renderer = ActionView::PartialRenderer.new(view_context.lookup_context, {})
        view_context.assign({ type.to_s => value })
        renderer.render(@partial, view_context, block).body
      end
    end
  end
end
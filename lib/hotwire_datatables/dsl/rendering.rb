module HotwireDatatables
  module RenderingDsl
    extend ActiveSupport::Concern

    class_methods do
      attr_reader :renderer, :row_renderer

      def render_with(renderer_type, *arguments)
        renderer_class = Rendering.const_get("#{renderer_type.classify}Renderer")
        @renderer = renderer_class.new(*arguments)
      end

      def renderer
        @renderer || Rendering::PartialRenderer.new('hotwire_datatables/table')
      end
    end
  end
end
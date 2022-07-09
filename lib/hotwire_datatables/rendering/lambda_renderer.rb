module HotwireDatatables
  module Rendering
    class LambdaRenderer
      def initialize(lambda)
        @lambda = lambda
      end

      def render(_view_context, _type, value, &_block)
        raise ArgumentError, "Lambda rendering does not support blocks" if block_given?

        @lambda.call(value)
      end
    end
  end
end
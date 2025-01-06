module FormBuilder
  module Tailwind
    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end
    end

    class Configuration
      attr_accessor :theme

      def initialize
        @theme = nil
      end
    end
  end
end 
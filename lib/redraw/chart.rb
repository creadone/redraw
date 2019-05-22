module Redraw
  class Chart

    def initialize(name)
      @name = name
      @klass = Object.const_set(@name, Class.new)
      @klass.class_eval do
        attr_reader :name, :config, :script, :style
        delegate :as_html, :as_json, :hash, to: :@config
      end
    end

    def define
      yield self
    end

    def configuration &block
      build &block
    end

    def script
      script = block_source
      @klass.instance_variable_set('@script', script)
    end

    def style
      style = block_source
      @klass.instance_variable_set('@style', style)
    end

    private

      def build &block
        if block_given?
          context = Context.new
          context.instance_eval &block
          wrapper = Wrapper.new(context.store)
          @klass.define_method(:initialize) do
            instance_variable_set('@config', wrapper)
          end
          # Redraw.class_factory(@name, @config)
        else
          raise "No block given"
        end
      end

  end
end

module Redraw
  class Chart

    def initialize(name)
      @chart_name = name
    end

    def build &block
      if block_given?
        context = Context.new
        context.instance_eval &block
        result = Wrapper.new(context.store)
        return Redraw.class_factory(@chart_name, result)
      else
        raise "No block given"
      end
    end
  end
end

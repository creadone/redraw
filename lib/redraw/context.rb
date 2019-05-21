module Redraw
  class Context
    attr_reader :store

    def initialize
      @store = {}
    end

    def method_missing name, *args, &block
      if @store.key? name
        raise "Key #{name} is already defined"
      end

      if block_given?
        context = self.class.new
        context.instance_eval &block
        result = context.store
      else
        if args.size == 0
          raise "No block or args given"
        elsif args.size == 1
          result = args[0]
        else
          result = args
        end
      end

      # Workaround for d3 when desired parameter
      # the same name as existing method or reserved Ruby word
      name = name[1..-1].to_sym if name.to_s.include?('_')
      @store[name] = result
    end
  end
end

module Redraw
  module Loader

    def self.load(name, **args)
      chart = Object.const_get(name).new
      chart.as_html
    end

  end
end

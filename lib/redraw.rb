require "redraw/version"
require "redraw/factory"
require "redraw/loader"
require "redraw/context"
require "redraw/wrapper"
require "redraw/chart"

module Redraw
  class Engine < ::Rails::Engine
  end
end

module Redraw
  module Helper

    def redraw_chart(name, **args)
      Loader.load(name, **args)
    end

  end
end

ActiveSupport.on_load(:action_view) do
  include Redraw::Helper
end

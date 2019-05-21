module Redraw
  # cls = Redraw.class_factory(name, content).new
  def self.class_factory(name, config)
    klass = Object.const_set(name, Class.new)
    klass.class_exec(config, name) do |config, name|
      attr_reader :config
      attr_reader :name

      delegate :as_html, :as_json, to: :@config

      define_method(:initialize) do
        instance_variable_set('@config', config)
        instance_variable_set('@name', name)
      end
    end
    klass
  end

end

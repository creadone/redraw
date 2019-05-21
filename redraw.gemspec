lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "redraw/version"

Gem::Specification.new do |spec|
  spec.name          = "redraw"
  spec.version       = Redraw::VERSION
  spec.summary       = "Prototyping tool for create custom charts with c3.js and Rails"
  spec.homepage      = "https://github.com/roleus/redraw"
  spec.license       = "MIT"

  spec.author        = "Sergey Fedorov"
  spec.email         = "creadone@gmail.com"

  spec.files         = Dir["*.{md,txt}", "{lib,vendor}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end

# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'torqml/version'

Gem::Specification.new do |s|
	s.name        = "torqml"
	s.version     = TorQML::VERSION
	s.authors     = ["Yuichi Tadokoro"]
	s.email       = ["tokoro10g@tokor.org"]
	s.homepage    = "http://torqml.tokor.org/"
	s.license     = "MIT"
	s.summary     = %q{A 3D visualization toolkit for simulations}
	s.description = %q{TorQML provides an architecture for describing 3D structures in Qt Quick QML and enables you to animate the models with numerical data series.}

	s.files         = `git ls-files -z`.split("\x0")
	s.executables   = s.files.grep(%r{^bin/}){ |f| File.basename(f) }
	s.test_files    = s.files.grep(%r{^(test,spec,features)/})
	s.require_paths = ["lib"]
	s.extensions = ["ext/TorQML/FrameGrabber/extconf.rb"]

	s.required_ruby_version = '>=2.0.0'

	s.add_runtime_dependency "qml", "~> 1.0"

	s.add_development_dependency "bundler", "~> 1.5"
	s.add_development_dependency "rake", "~> 10.3"
	s.add_development_dependency "rspec", "~> 3.0"
end

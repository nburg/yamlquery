# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yamlquery/version'

Gem::Specification.new do |spec|
  spec.name          = "yamlquery"
  spec.version       = YamlQuery::VERSION
  spec.authors       = ["Nicholas Burgess"]
  spec.email         = ["nburgess@uchicago.edu"]

  spec.summary          = 'YamlQuery helps you search yaml files.'
  spec.description      = 'Search and set values in multiple yaml files. This is particularly useful for wrangling data in puppetlabs hiera.'
  spec.homepage      = "http://github.com/nburg/yamlquery"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["yq"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", '~> 0.10.4'
 
  spec.add_runtime_dependency "parslet", '~> 1.7.1'
end

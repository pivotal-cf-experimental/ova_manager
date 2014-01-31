# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ova_manager/version'

Gem::Specification.new do |spec|
  spec.name          = "ova_manager"
  spec.version       = OvaManager::VERSION
  spec.authors       = ["Pivotal Software, Inc"]
  spec.email         = ["pivotal-cf@googlegroups.com"]
  spec.description   = %q{CLI tools to deploy/delete an OVA to vSphere}
  spec.summary       = %q{CLI tools to deploy/delete an OVA to vSphere}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "rbvmomi"
  spec.add_dependency "vsphere_clients"
end

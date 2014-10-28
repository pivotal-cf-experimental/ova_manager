Gem::Specification.new do |spec|
  spec.name          = "ova_manager"
  spec.version       = "0.1.0"
  spec.authors       = ""
  spec.summary       = "CLI tools to deploy/delete an OVA to vSphere"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rbvmomi", "~> 1.6.0"
  spec.add_dependency "vsphere_clients"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-instafail"
end

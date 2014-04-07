Gem::Specification.new do |spec|
  spec.name          = "ova_manager"
  spec.version       = "0.0.0"
  spec.authors       = ""
  spec.summary       = "CLI tools to deploy/delete an OVA to vSphere"

  spec.files         = Dir["lib/**/*"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "rbvmomi"
  spec.add_dependency "vsphere_clients"
end

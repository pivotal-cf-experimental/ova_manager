# OvaManager
Deploy/Destroy OVA to vSphere.

## Installation
```bash
cd $installation_directory/vsphere_clients
gem install vsphere_clients-*gem

cd $installation_directory/ova_manager
gem install ova_manager-*gem
```

## Usage
#### To deploy an OVA
```ruby
OvaManager::Deployer.new("name-prefix", {
  host: @host,
  user: @user,
  password: @password
}, {
  datacenter: @datacenter,
  cluster: @cluster,
  datastore: @datastore,
  network: @network,
  folder: @vm_folder
}).deploy(@ova_path, {
  ip: @target_ip,
  netmask: @netmask,
  gateway: @gateway,
  dns: @dns,
  ntp_servers: @ntp_servers,
  vm_password: @vm_password
})
```
	
#### To destroy an OVA
```ruby
OvaManager::Destroyer.new(@datacenter, {
    host: @host,
	user: @user,
	password: @password
}).clean_folder(@vm_folder)
```

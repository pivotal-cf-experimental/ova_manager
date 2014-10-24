require "rbvmomi"
require "logger"
require "vsphere_clients/vm_folder_client"

module OvaManager
  class Destroyer
    def initialize(datacenter_name, vcenter)
      @datacenter_name = datacenter_name
      @vcenter = vcenter
    end

    def clean_folder(folder_name)
      vm_folder_client.delete_folder(folder_name)
      vm_folder_client.create_folder(folder_name)
    end

    private

    def vm_folder_client
      @vm_folder_client ||= VsphereClients::VmFolderClient.new(datacenter, Logger.new(STDERR))
    end

    def datacenter
      match = connection.searchIndex.FindByInventoryPath(inventoryPath: @datacenter_name)
      return unless match and match.is_a?(RbVmomi::VIM::Datacenter)
      match
    end

    def connection
      RbVmomi::VIM.connect(
        host: @vcenter[:host],
        user: @vcenter[:user],
        password: @vcenter[:password],
        ssl: true,
        insecure: true,
      )
    end
  end
end

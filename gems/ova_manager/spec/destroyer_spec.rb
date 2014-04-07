require "destroyer"

describe OvaManager::Destroyer do
  subject(:destroyer) { described_class.new("datacenter_name", vcenter) }
  let(:vcenter) { { host: "host", user: "user", password: "password" } }

  describe "#clean_folder" do

    # Crappy temporary test to at least ensure that Destroyer requires the appropriate files
    it "is wired up correctly" do
      connection = double("connection", serviceInstance: double("serviceInstance"))
      datacenter = double("datacenter")
      vm_folder_client = double("vm_folder_client")

      RbVmomi::VIM.should_receive(:connect).with(
        host: "host",
        user: "user",
        password: "password",
        ssl: true,
        insecure: true,
      ).and_return(connection)
      connection.serviceInstance.should_receive(:find_datacenter).with("datacenter_name").and_return(datacenter)
      VsphereClients::VmFolderClient.should_receive(:new).with(datacenter, instance_of(Logger)).and_return(vm_folder_client)

      vm_folder_client.should_receive(:delete_folder).with("folder_name")
      vm_folder_client.should_receive(:create_folder).with("folder_name")

      destroyer.clean_folder("folder_name")
    end
  end
end

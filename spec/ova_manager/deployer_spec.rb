require 'spec_helper'
require 'tempfile'
require 'ova_manager/deployer'

describe OvaManager::Deployer do

  let(:connection) {double('connection')}
  let(:cluster) {double('cluster')}
  let(:target_folder) {double('target_folder')}
  let(:datastore) {double('datastore')}
  let(:network) {double('network', name: 'network')}
  let(:datacenter) {double('datacenter', network: [network])}
  let(:cached_ova_deployer) {
    double('CachedOvaDeployer', upload_ovf_as_template: template, linked_clone: linked_clone )
  }
  let(:template) { double('template', name: 'template name') }
  let(:ova_path) {File.join('spec','fixtures','foo.ova')}
  let(:linked_clone) {double('linked clone', guest_ip: '1.1.1.1')}
  let(:vcenter) {
    {
      host: 'foo',
      user: 'bar',
      password: 'secret'
    }
  }
  let(:location){
    {
      connection: connection,
      network: 'network',
      cluster: 'cluster',
      folder: 'target_folder',
      datastore: 'datastore',
      datacenter: 'datacenter',
      resource_pool_name: 'resource_pool_name'
    }
  }

  let(:ova_manager_deployer){ OvaManager::Deployer.new(vcenter, location) }

  before do
    allow(ova_manager_deployer).to receive(:system).and_call_original
    allow(ova_manager_deployer).to receive(:system).with('ping -c 5 1.1.1.1').and_return(false)

    allow(datacenter).to receive(:find_compute_resource).with('cluster').and_return(cluster)
    allow(datacenter).to receive(:find_datastore).with('datastore').and_return(datastore)

    allow(linked_clone).to receive_message_chain(:ReconfigVM_Task, :wait_for_completion)
    allow(linked_clone).to receive_message_chain(:PowerOnVM_Task, :wait_for_completion)

    allow(RbVmomi::VIM).to receive(:connect).with({
                                                    host:     vcenter[:host],
                                                    user:     vcenter[:user],
                                                    password: vcenter[:password],
                                                    ssl:      true,
                                                    insecure: true
                                                  }).and_return connection

    allow(connection).to receive_message_chain(:serviceInstance, :find_datacenter).with('datacenter').and_return(datacenter)

    allow(datacenter).to receive_message_chain(:vmFolder, :traverse).
                           with('target_folder', RbVmomi::VIM::Folder, true).and_return(target_folder)
  end

  it 'uses VsphereClient::CachedOvfDeployer to deploy an OVA within a resource pool' do
    expect(VsphereClients::CachedOvfDeployer).to receive(:new).with(
      connection,
      network,
      cluster,
      'resource_pool_name',
      target_folder,
      target_folder,
      datastore
    ).and_return(cached_ova_deployer)

    ova_manager_deployer.deploy('foo', ova_path, {ip: '1.1.1.1'})
  end

  context 'when there is no resource pool name' do
    let(:location){
      {
        connection: connection,
        network: 'network',
        cluster: 'cluster',
        folder: 'target_folder',
        datastore: 'datastore',
        datacenter: 'datacenter',
      }
    }

    it 'fails to find resource pool name' do

      expect{ ova_manager_deployer.deploy('foo', ova_path, {ip: '1.1.1.1'}) }.
        to raise_error /Failed to find resource_pool_name/

    end
  end
end
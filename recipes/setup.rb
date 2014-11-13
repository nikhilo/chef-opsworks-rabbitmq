#
# Cookbook Name:: rabbit
# Recipe:: setup
#
# Copyright (C) 2014 Baldur Rensch
#
# All rights reserved - Do Not Redistribute
#

directory "/etc/rabbitmq/ssl" do
  owner "root"
  group "root"
  recursive true
end

# Install the certs
file "/etc/rabbitmq/ssl/cacert.pem" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  content node['rabbit']['ssl']['cacert']
  only_if { node['rabbit']['ssl']['cacert'] }
end

file "/etc/rabbitmq/ssl/cert.pem" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  content node['rabbit']['ssl']['cert']
  only_if { node['rabbit']['ssl']['cert'] }
end

file "/etc/rabbitmq/ssl/key.pem" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  content node['rabbit']['ssl']['key']
  only_if { node['rabbit']['ssl']['key'] }
end

# Add all rabbitmq nodes to the hosts file with their short name.
instances = node[:opsworks][:layers][:rabbitmq][:instances]

rabbit_nodes = instances.map{ |name, attrs| "rabbit@#{name}" }
node.set['rabbitmq']['cluster_disk_nodes'] = rabbit_nodes

include_recipe 'rabbitmq'
include_recipe 'rabbitmq::mgmt_console'

include_recipe 'rabbit::apply_configuration'

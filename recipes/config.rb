#
# Cookbook Name:: rabbit
# Recipe::config
#
# Copyright (C) 2014 Baldur Rensch
#
# All rights reserved - Do Not Redistribute
#

# Add all rabbitmq nodes to the hosts file with their short name.
instances = node[:opsworks][:layers][:rabbitmq][:instances]

instances.each do |name, attrs|
  log "Adding node " + name + " to hostfile"
  hostsfile_entry attrs['private_ip'] do
    hostname  name
    unique    true
  end
end

rabbit_nodes = instances.map{ |name, attrs| "rabbit@#{name}" }
node.set['rabbitmq']['cluster_disk_nodes'] = rabbit_nodes

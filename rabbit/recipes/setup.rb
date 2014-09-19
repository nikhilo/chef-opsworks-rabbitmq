#
# Cookbook Name:: rabbit
# Recipe:: setup
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

include_recipe 'rabbitmq'

execute "chown -R rabbitmq:rabbitmq /var/lib/rabbitmq"

rabbitmq_user "guest" do
  action :delete
end

rabbitmq_user node['rabbitmq_cluster']['user'] do
  password node['rabbitmq_cluster']['password']
  action :add
end

rabbitmq_user node['rabbitmq_cluster']['user'] do
  vhost "/"
  permissions ".* .* .*"
  action :set_permissions
end

include_recipe "rabbitmq::mgmt_console"

# Blow away the mnesia database. This is necessary so the nodes
# in the cluster will be able to recognize each other (this
# should only happen once... the first time we install RabbitMQ)
bash "Reset mnesia" do
  user "root"
  cwd "/var/lib/rabbitmq"
  code <<-EOH
    rm -rf mnesia/
    touch .reset_mnesia_database
  EOH
  not_if do
    File.exists?("/var/lib/rabbitmq/.reset_mnesia_database")
  end
end

# Restart the server. 
bash "Restart RabbitMQ" do
  user "root"
  code <<-EOH
    rabbitmqctl stop_app
    rabbitmqctl reset
    rabbitmqctl stop
    service rabbitmq-server restart
  EOH
end

# Repositories
# include_recipe 'rabbitmq::remi'
# include_recipe 'rabbitmq::remi-php55'

# include_recipe 'php'

# %w{php-pdo php-pgsql php-intl php-pecl-apcu php-mbstring php-opcache}.each do |p|
# 	package p do
# 		action :install
# 	end
# end

# # This is for later refactoring. rabbitmq specific
# package "php-ldap" do
# 	action :install
# end

# include_recipe 'php-fpm'
# php_fpm_pool 'www' do
# 	user "nginx"
# 	group "nobody"
# 	listen_owner "nginx"
# 	listen_group "nobody"
# end

# include_recipe 'nginx'

# we need the rabbitmq cluster_disk_nodes configuration to be updated
include_recipe 'rabbit::setup'

bash "Reset RabbitMQ" do
  user "root"
  code <<-EOH
    rabbitmqctl stop_app
    rabbitmqctl reset # this will reset the rabbitmq database, allowing the node to try joining the cluster
  EOH
  notifies :restart, "service[#{node['rabbitmq']['service_name']}]", :immediately
end

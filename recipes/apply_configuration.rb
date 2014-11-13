service node['rabbitmq']['service_name'] do
  action :start
end

rabbitmq_user "guest" do
  action :delete
end

rabbitmq_user node['rabbit']['user'] do
  password node['rabbit']['password']
  action :add
end

rabbitmq_user node['rabbit']['user'] do
  vhost "/"
  permissions ".* .* .*"
  action :set_permissions
end

rabbitmq_user node['rabbit']['user'] do
  tag "administrator"
  action :set_tags
end

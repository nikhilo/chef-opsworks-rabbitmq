if not node['rabbit']['route_53_zone_id'].nil?
  include_recipe "route53"

  record = "#{node[:opsworks][:instance][:hostname]}.#{node['rabbit']['domain']}"

  route53_record record do
    name record
    value node[:opsworks][:instance][:private_ip]
    type "A"
    zone_id node[:rabbit][:route_53_zone_id]
    overwrite true
    action :create
  end

  file "/etc/dhcp/dhclient.conf" do
    action :create
    content <<-eos
timeout 300;

append domain-search "#{node['rabbit']['domain']}";
    eos
  end

  service "network" do
    action :restart
  end
end

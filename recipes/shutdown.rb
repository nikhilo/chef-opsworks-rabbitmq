if not node['rabbit']['route_53_zone_id'].nil?
  include_recipe "route53"

  record = "#{node[:opsworks][:instance][:hostname]}.#{node['rabbit']['domain']}"

  route53_record record do
    name record
    type "A"
    zone_id node[:rabbit][:route_53_zone_id]
    action :delete
  end
end

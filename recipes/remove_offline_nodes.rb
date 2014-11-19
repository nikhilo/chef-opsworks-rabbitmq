cookbook_file "/usr/local/bin/remove_offline_nodes" do
  source 'remove_offline_nodes.sh'
  owner 'root'
  group 'root'
  mode '770'
end

execute '/usr/local/bin/remove_offline_nodes'

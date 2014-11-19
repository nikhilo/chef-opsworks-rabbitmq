bash 'remove_offline_nodes' do
  cwd '/tmp'
  code <<-EOH
    rm -f {nodes,running_nodes,offline_nodes}.txt

    rabbitmqctl cluster_status | grep running_nodes | grep -oE "\w+@\w+" | sort > running_nodes.txt
    rabbitmqctl cluster_status | grep "\[{nodes," | grep -oE "\w+@\w+" | sort > nodes.txt

    comm -23 nodes.txt running_nodes.txt > offline_nodes.txt

    cat offline_nodes.txt | while read node
    do
      rabbitmqctl forget_cluster_node $node
    done
  EOH
end

cluster-name     = "eks-cluster-demo"
node-group-names = ["node-group-1", "node-group-2"]
worker_EBS_volume_size        = 20
worker_node_instance_type     = "t2.medium"
worker_node_desired_instances = 2
worker_node_max_instances     = 4
worker_node_min_instances     = 2
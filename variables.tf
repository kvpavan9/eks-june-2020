variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "master_subnet_ids" {
  type = list(string)
  description = "master subnetid info"
}
variable "worker_subnet_ids" {
  description = "provide subnet_id's for two lanuhc worker node in which subnet"
  type        = list(string)
}

// https://docs.aws.amazon.com/eks/latest/userguide/platform-versions.html
variable "kubernetes_version" {
  default     = "" // If empty, will use the newest
  description = "Kubernetes version"
}

variable "nodes" {
  type = number

  description = <<EOF
List of maps, e.g:
{
  desired_nodes = "1"
  max_nodes     = "1"
  min_nodes     = "1"
  instance_type = "m5.large"
},
{
  desired_nodes = "1"
  max_nodes     = "1"
  min_nodes     = "1"
  instance_type = "m5.xlarge"
},
EOF

}

variable "node_ami_id" {
  type        = string
  description = "AMI ID to use for worker nodes"
  default     = ""
}

variable "extend_node_user_data" {
  default = ""
}

variable "alb_target_group_arns" {
  type    = list(string)
  default = []
}

variable "enabled_cluster_log_types" {
  type    = list(string)
  default = []
}


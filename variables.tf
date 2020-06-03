variable "node-group-names" {
  description = "provide node group names"
  type        = list(string)
}
variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = string
}


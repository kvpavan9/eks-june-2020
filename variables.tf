variable "node-group-names" {
  description = "provide node group names"
  type        = list(string)
}
variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = string
}

variable "kubernetes_version" {
  description = "specify kubernetes version, at this movement we have 1.14,1.15 and 1.16"
  type        = string
  default     = ""  // it means , it will automatically take default version
}



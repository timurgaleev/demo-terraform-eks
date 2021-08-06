#data

data "aws_region" "current" {}

data "aws_ami" "eks_gpu_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-gpu-node-${var.cluster_version}-*"]
  }

  most_recent = true
  owners      = ["602401143452"]
}

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

#eks

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.53.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    helm       = ">= 1.0"
    kubernetes = ">= 1.11"
  }
  required_version = ">= 0.14"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "v17.1.0"
  cluster_version = var.cluster_version
  cluster_name    = var.cluster_name
  kubeconfig_name = var.cluster_name
  subnets         = var.subnets
  vpc_id          = var.vpc_id
  enable_irsa     = false

  workers_additional_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53AutoNamingFullAccess",
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
  ]

  map_users = concat(var.admin_arns, var.user_arns)

  workers_group_defaults = {
    additional_userdata  = "sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm && sudo systemctl enable amazon-ssm-agent && sudo systemctl start amazon-ssm-agent"
    bootstrap_extra_args = "--docker-config-json ${local.docker_config_json}"
  }

  worker_groups_launch_template = concat(local.common, local.cpu, local.gpu)

  tags = {
    Project = var.project
  }
}

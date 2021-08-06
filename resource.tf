#resource

resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  url             = module.eks.cluster_oidc_issuer_url
}

resource "kubernetes_namespace" "this" {
  count = var.namespace == "kube-system" ? 1 : 0
  metadata {
    name = var.namespace_name
  }
}

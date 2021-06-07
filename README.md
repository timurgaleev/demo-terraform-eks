# god-terraform-eks

<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_log\_retention\_in\_days | Number of days to retain log events. Default retention - 90 days. | `number` | `14` | no |
| cluster\_log\_types | A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| eks\_oidc\_thumbprint | Thumbprint of Root CA for EKS OIDC, Valid until 2037 | `string` | `"9e99a48a9960b14926bb7f3b02e22da2b0ab7280"` | no |
| irsa\_enabled | Whether to create OpenID Connect Provider for EKS to enable IRSA | `bool` | `true` | no |
| kubernetes\_version | n/a | `string` | `"1.18"` | no |
| name | Name of the cluster, e.g: dev-demo-eks | `any` | n/a | yes |
| region | The region to deploy the cluster in, e.g: us-east-1 | `any` | n/a | yes |
| roles | Additional IAM roles to add to the aws-auth configmap. | `list` | `[]` | no |
| save\_local\_file | n/a | `bool` | `false` | no |
| tags | n/a | `map(string)` | `{}` | no |
| users | Additional IAM users to add to the aws-auth configmap. | `list` | `[]` | no |
| vpc\_id | n/a | `string` | `""` | no |
| workers | Additional worker node roles to add to the aws-auth configmap. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| kubeconfig\_filename | n/a |
| cluster\_name | n/a |
| cluster\output | n/a |
| workers\_launch\_template\_ids | n/a |

<!--- END_TF_DOCS --->

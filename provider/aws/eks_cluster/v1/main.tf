resource "aws_eks_cluster" "main" {
  name     = var.name
  role_arn = var.role_arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    security_group_ids = var.security_group_ids
  }


  #   # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  #   # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  #   depends_on = [
  #     aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
  #     aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  #   ]

  tags = var.tags
}

data "tls_certificate" "main" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "main" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.main.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.main.url
}

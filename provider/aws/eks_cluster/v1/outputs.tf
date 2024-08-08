output "eks_endpoint" {
  value = "${aws_eks_cluster.main.endpoint}"
}

output "eks_cluster_name" {
  value = "${aws_eks_cluster.main.id}"
}

output "eks_cluster_certificate_authority_data" {
  value = "${aws_eks_cluster.main.certificate_authority[0].data}"
}

output "eks_cluster_identity_oidc_issuer"{
  value = "${aws_eks_cluster.main.identity[0].oidc[0].issuer}"
}

output "eks_cluster_arn"{
  value = "${aws_eks_cluster.main.arn}"
}
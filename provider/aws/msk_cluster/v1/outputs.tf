output "msk_cluster_arn" {
  value = "${aws_msk_cluster.main.arn}"
}

output "msk_cluster_bootstrap_brokers_tls" {
  value = "${aws_msk_cluster.main.bootstrap_brokers_tls}"
}
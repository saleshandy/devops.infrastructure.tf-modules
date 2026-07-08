*Example*
```
module "example_bucket_policy" {
  source = "./terraform-modules/provider/aws/s3_bucket_policy/v1"

  depends_on = [
    module.example_s3_bucket,
    module.example_iam_access_key_user_demouser
  ]
  bucket = module.example_s3_bucket.s3_bucket_bucket
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Deny",
          "NotPrincipal" : {
            "AWS" : [
              "arn:aws:iam::${var.aws_account_number}:user/${var.terraform_user}",
              "arn:aws:iam::${var.aws_account_number}:user/${module.example_iam_access_key_user_demouser.iam_user_name}",
              "arn:aws:iam::${var.aws_account_number}:root"
            ]
          },
          "Action" : "s3:*",
          "Resource" : [
            "${module.example_s3_bucket.s3_bucket_arn}",
            "${module.example_s3_bucket.s3_bucket_arn}/*",
          ]
        }
      ]
    }
  )
}
```
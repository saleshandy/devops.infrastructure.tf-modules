*Example*
```
module "example_iam_user_policy" {
  depends_on = [
    module.example_s3_bucket
  ]
  source = "./terraform-modules/provider/aws/iam_policy/v1"
  name   = "user_restriction"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:PutObjectAcl",
          "s3:ListBucket"
        ],
        "Resource" : [
          "${module.example_s3_bucket.s3_bucket_arn}",
          "${module.example_s3_bucket.s3_bucket_arn}/*",
        ]
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : "s3:ListAllMyBuckets",
        "Resource" : "*"
      }
    ]
  })
}
```
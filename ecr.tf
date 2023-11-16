module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "Practise-repo"
  repository_lambda_read_access_arns = ["arn:aws:iam::615238735504:user/my_user"]
  repository_lifecycle_policy = jsondecode({
   rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
})
tags = {
    Terraform = "true"
    Environment = "Dev"
}
}

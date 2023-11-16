module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name = "my-table"
  hash_key = "id"
  range_key = "Sname"

  attributes = [
    {
        name = "id"
        type = "N"
    },
    {
        name = "Sname"
        type = "S"
    }
  ]

  tags = {
    Terraform = "true"
    Enivironment = "staging"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

data "aws_vpc" "default" {
  default = true
}


/*
다른 vpc를 사용할려면
data "aws vpc" "project-vpc" {
  id = "<사 용 하려는 vpc ID>"
}

data "aws vpc" "project-vpc" {
  filter {
     name = "tag:Name"
     value = ["Project-VPC"]
  }
}

*/



data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "default" {
  for_each = toset(data.aws_subnets.default.ids)
  id    = each.value
}


output "vpc-id" {
  value = data.aws_vpc.default.id
}

output "subnet-cidr_blocks" {
  value = [ for s in data.aws_subnet.default : s.cidr_block]
}





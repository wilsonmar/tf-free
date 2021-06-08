<!-- BEGIN_TF_DOCS -->

### Modules

| Name | Source                        | Version |
| ---- | ----------------------------- | ------- |
| ec2  | ./ec2                         |         |
| rds  | ./rds                         |         |
| vpc  | terraform-aws-modules/vpc/aws |         |

### Inputs

| Name           | Description                          | Type     | Default                        |
| -------------- | ------------------------------------ | -------- | ------------------------------ |
| account_id     | Region for AWS resources             | `string` | n/a                            |
| account_key    | Region for AWS resources             | `string` | n/a                            |
| ec2_ssh_name   | The SSH Key Name                     | `string` | `"free-tier-ec2-key"`          |
| ec2_ssh_public | The local path to the SSH Public Key | `string` | `"aws.pub"`                    |
| profile        | AWS Profile                          | `string` | `"terraform"`                  |
| rds_password   | Region for AWS resources             | `string` | `"testingdatabase89372934279"` |
| rds_user       | Region for AWS resources             | `string` | `"testing"`                    |
| region         | Region for AWS resources             | `string` | `"us-east-1"`                  |

### Outputs

| Name               | Description                                                          |
| ------------------ | -------------------------------------------------------------------- |
| ec2_ipv6_addresses | List of assigned IPv6 addresses of instances                         |
| ec2_key_name       | List of key names of instances                                       |
| ec2_password_data  | List of Base-64 encoded encrypted password data for the instance     |
| ec2_private_ip     | List of private IP addresses assigned to the instances               |
| ec2_public_ip      | List of public IP addresses assigned to the instances, if applicable |

<!-- END_TF_DOCS -->

## Example

```hcl
provider "aws" {
  region     = var.aws_default_region
  access_key = var.aws_account_id
  secret_key = var.aws_account_key
}

module "vpc" {
  source = "../../../../modules/aws/vpc"
  name   = "vpc-test-ec2"
}

module "public_subnet" {
  source            = "../../../../modules/aws/subnet"
  name              = "subnet-test-ec2"
  availability_zone = var.subnet_region
  vpc_id            = module.vpc.id
}

module "internet_gateway" {
  source = "../../../../modules/aws/gateway"
  name   = "igw-test-ec2"
  vpc_id = module.vpc.id
}

module "route_table" {
  source = "../../../../modules/aws/firewall"

  name                = "table-test-ec2"
  vpc_id              = module.vpc.id
  internet_gateway_id = module.internet_gateway.id
  public_subnet_id    = module.public_subnet.id
}

module "ec2" {
  source           = "../../../../modules/aws/ec2"
  name             = "ec2-test-ec2"
  vpc_id           = module.vpc.id
  ami              = var.ami_id
  seed_data        = <<EOF
#!/bin/bash
echo "Hello, World!" > index.html
nohup busybox httpd -f -p 80 &
EOF
  public_subnet_id = module.public_subnet.id
  ssh_name         = var.ssh_name
  ssh_public       = var.ssh_public
}

```
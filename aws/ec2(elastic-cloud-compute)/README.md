# EC2 Instance Setup Guide

## 1. Pre-requisites

Before launching an EC2 instance, ensure you have:

- An AWS account
- AWS CLI installed and configured (`aws configure`)
- An IAM user with `AdministratorAccess` or sufficient permissions
- SSH Key Pair for secure access

## 2. Launch EC2 Instance

### Using AWS Management Console

1. Navigate to **EC2 Dashboard**.
2. Click **Launch Instance**.
3. Select an **Amazon Machine Image (AMI)** (e.g., Amazon Linux 2, Ubuntu).
4. Choose an instance type (e.g., `t2.micro` for free tier or `t3.medium` for better performance).
5. Configure instance details:
   - Number of instances
   - Network (VPC & Subnet)
   - Auto-assign Public IP (Enable if required)
   - IAM Role (if needed)
6. Add storage (e.g., 30GB GP3 SSD for production workloads).
7. Configure security group:
   - Allow SSH (Port 22) from your IP
   - Open necessary ports (e.g., 80 for HTTP, 443 for HTTPS)
8. Select an existing key pair or create a new one.
9. Review and launch the instance.

### Using AWS CLI

```sh
aws ec2 run-instances \
  --image-id ami-0abcdef1234567890 \
  --count 1 \
  --instance-type t3.medium \
  --key-name MyKeyPair \
  --security-group-ids sg-0abcd1234 \
  --subnet-id subnet-0abcd1234 \
  --associate-public-ip-address
```

## 3. Connecting to the Instance

```sh
ssh -i MyKeyPair.pem ec2-user@<INSTANCE_PUBLIC_IP>
```

## 4. Installing Required Software

Once connected:

```sh
sudo yum update -y  # For Amazon Linux
sudo apt update -y  # For Ubuntu

# Install common tools
sudo yum install -y git vim docker
```

## 5. Setting Up Monitoring & Logging

- Enable CloudWatch agent for logs and metrics.
- Install and configure **CloudWatch Agent**:

```sh
sudo yum install -y amazon-cloudwatch-agent
sudo systemctl enable amazon-cloudwatch-agent
sudo systemctl start amazon-cloudwatch-agent
```

## 6. Automating with Terraform (Optional)

For infrastructure as code (IaC), define EC2 in a Terraform file (`ec2.tf`):

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.medium"
  key_name      = "MyKeyPair"
  security_groups = ["default"]
}
```

Apply the configuration:

```sh
terraform init
terraform apply -auto-approve
```

## 7. Next Steps

- Set up IAM roles for better security.
- Configure auto-scaling for high availability.
- Use Ansible/Puppet for configuration management.

---
This guide provides a comprehensive approach to launching and configuring an EC2 instance for development or production use.

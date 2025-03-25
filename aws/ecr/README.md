# Amazon ECR Setup Guide

## 1. Pre-requisites

Before setting up Amazon Elastic Container Registry (ECR), ensure you have:

- An AWS account
- AWS CLI installed and configured (`aws configure`)
- IAM user/role with `AmazonEC2ContainerRegistryFullAccess` permissions
- Docker installed on your local machine

## 2. Create an ECR Repository

### Using AWS Management Console

1. Navigate to **Amazon ECR** in AWS Console.
2. Click **Create repository**.
3. Set a **Repository name** (e.g., `my-app-repo`).
4. Select **Private** or **Public** visibility.
5. Enable **scan on push** (optional for security checks).
6. Click **Create repository**.

### Using AWS CLI

```sh
aws ecr create-repository --repository-name my-app-repo
```

Output:

```json
{
    "repository": {
        "repositoryArn": "arn:aws:ecr:us-east-1:123456789012:repository/my-app-repo",
        "repositoryUri": "123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app-repo"
    }
}
```

## 3. Authenticate Docker with ECR

Retrieve and execute the authentication command:

```sh
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com
```

## 4. Build & Push Docker Image to ECR

1. Build the Docker image:

```sh
docker build -t my-app .
```

2. Tag the image for ECR:

```sh
docker tag my-app:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app-repo:latest
```

3. Push the image to ECR:

```sh
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app-repo:latest
```

## 5. Pull & Use Image from ECR

To pull the image:

```sh
docker pull 123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app-repo:latest
```

## 6. Automating with Terraform (Optional)

Define ECR in a Terraform file (`ecr.tf`):

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "my_repo" {
  name = "my-app-repo"
}
```

Apply the configuration:

```sh
terraform init
terraform apply -auto-approve
```

## 7. Next Steps

- Integrate ECR with ECS, EKS, or CI/CD pipelines.
- Set up lifecycle policies to optimize storage.
- Enable encryption and IAM policies for security.

---
This guide covers setting up Amazon ECR, pushing/pulling images, and automation using Terraform.

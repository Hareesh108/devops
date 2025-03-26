# Amazon S3 Setup Guide

## 1. Pre-requisites

Before setting up Amazon S3, ensure you have:

- An AWS account
- AWS CLI installed and configured (`aws configure`)
- IAM user/role with `AmazonS3FullAccess` permissions

## 2. Create an S3 Bucket

### Using AWS Management Console

1. Navigate to **Amazon S3** in AWS Console.
2. Click **Create bucket**.
3. Set a **Bucket name** (e.g., `my-app-bucket`).
4. Choose an AWS **Region**.
5. Configure settings:
   - **Block Public Access** (recommended for private data)
   - **Versioning** (enable if needed)
   - **Encryption** (SSE-S3, SSE-KMS, etc.)
6. Click **Create bucket**.

### Using AWS CLI

```sh
aws s3api create-bucket --bucket my-app-bucket --region us-east-1 --create-bucket-configuration LocationConstraint=us-east-1
```

## 3. Upload Files to S3

### Using AWS Console

1. Open the S3 bucket.
2. Click **Upload** and select files.
3. Set permissions and encryption (if needed).
4. Click **Upload**.

### Using AWS CLI

```sh
aws s3 cp my-file.txt s3://my-app-bucket/
```

## 4. Enable Public Access (Optional)

If public access is required, update the bucket policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-app-bucket/*"
    }
  ]
}
```

Apply the policy:

```sh
aws s3api put-bucket-policy --bucket my-app-bucket --policy file://policy.json
```

## 5. Automating with Terraform (Optional)

Define S3 bucket in a Terraform file (`s3.tf`):

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-app-bucket"
  acl    = "private"
}
```

Apply the configuration:

```sh
terraform init
terraform apply -auto-approve
```

## 6. Next Steps

- Enable **S3 Lifecycle Policies** to manage storage costs.
- Integrate with **CloudFront** for content delivery.
- Set up **event notifications** for Lambda or SNS integration.

---
This guide covers setting up Amazon S3, uploading files, managing access, and automating with Terraform.

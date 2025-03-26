# Deploy Next.js App with AWS CloudFront

## 1. Pre-requisites

Before deploying a Next.js app with CloudFront, ensure you have:

- An AWS account
- AWS CLI installed and configured (`aws configure`)
- A Next.js application ready for deployment
- AWS S3 and CloudFront permissions

## 2. Build Next.js Application

```sh
npm install
npm run build
```

The output will be stored in the `.next` folder.

## 3. Export Static Files

```sh
npm run export
```

This generates a `out/` folder with the static files.

## 4. Create an S3 Bucket for Hosting

### Using AWS CLI

```sh
aws s3 mb s3://my-nextjs-app --region us-east-1
```

Enable static website hosting:

```sh
aws s3 website s3://my-nextjs-app/ --index-document index.html
```

## 5. Upload Files to S3

```sh
aws s3 sync ./out s3://my-nextjs-app --acl public-read
```

## 6. Set Up CloudFront Distribution

### Using AWS Console

1. Navigate to **CloudFront** in AWS Console.
2. Click **Create Distribution**.
3. Select **Origin** as your S3 bucket (`my-nextjs-app.s3.amazonaws.com`).
4. Set **Default Root Object** to `index.html`.
5. Enable **Compression** and **Caching Policies**.
6. Click **Create Distribution**.

### Using AWS CLI

```sh
aws cloudfront create-distribution --origin-domain-name my-nextjs-app.s3.amazonaws.com --default-root-object index.html
```

## 7. Automating with Terraform (Optional)

Define S3 and CloudFront in `terraform.tf`:

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "nextjs" {
  bucket = "my-nextjs-app"
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.nextjs.bucket_regional_domain_name
    origin_id   = "S3Origin"
  }
}
```

Apply the configuration:

```sh
terraform init
terraform apply -auto-approve
```

## 8. Next Steps

- Use a **custom domain** with Route 53.
- Enable **CloudFront invalidations** for cache updates.
- Implement **Lambda@Edge** for advanced request processing.

---
This guide covers deploying a Next.js app using AWS S3 and CloudFront for high availability and performance.

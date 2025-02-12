# Deploying Next.js Application to AWS S3 & CloudFront

## **1. Build and Export Next.js App**

AWS S3 serves static files, so export your Next.js app:

```sh
npm run build
npm run export
```

This will generate an `out` directory containing the static files.

---

## **2. Create an S3 Bucket**

1. Go to [AWS S3 Console](https://s3.console.aws.amazon.com/s3/home).
2. Click **Create Bucket** and configure:
   - Set a **unique bucket name**.
   - Choose a region.
   - Disable **Block all public access** (if serving publicly).
   - Enable **Static Website Hosting**.
   - Set index document to `index.html`.
3. Click **Create Bucket**.

---

## **3. Upload Files to S3**

Use AWS CLI or the console to upload the `out` folder:

```sh
aws s3 sync out s3://your-bucket-name --delete
```

Replace `your-bucket-name` with your actual S3 bucket name.

---

## **4. Set Up CloudFront (CDN)**

1. Go to [AWS CloudFront Console](https://console.aws.amazon.com/cloudfront/home).
2. Click **Create Distribution**.
3. Under **Origin Settings**:
   - Set **Origin Domain Name** to your S3 bucket.
   - Enable **Redirect HTTP to HTTPS**.
4. Under **Default Cache Behavior**:
   - Set **Viewer Protocol Policy** to `Redirect HTTP to HTTPS`.
   - Allow `GET, HEAD, OPTIONS` methods.
5. Click **Create Distribution**.

---

## **5. Configure S3 Bucket Policy**

Ensure your S3 bucket is accessible by CloudFront:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::your-bucket-name/*"
    }
  ]
}
```

Replace `your-bucket-name` accordingly.

---

## **6. Update DNS for Custom Domain (Optional)**

1. Go to **Route 53** or your DNS provider.
2. Create a **CNAME record** pointing your domain to the CloudFront distribution URL.

---

## **7. Automate Deployment with AWS CLI**

Use AWS CLI to deploy updates:

```sh
npm run build && npm run export
aws s3 sync out s3://your-bucket-name --delete
```

---

Your Next.js app is now live on AWS S3 with CloudFront! 🚀

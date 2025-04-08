# AWS S3 Lifecycle Rules Setup Guide (Basic to Advanced)

## 1. What are Lifecycle Rules?

Lifecycle rules in Amazon S3 allow you to automatically manage the lifecycle of objects in a bucket. You can transition objects to different storage classes or expire them after a certain period.

---

## 2. Pre-requisites

- An AWS account
- An existing S3 bucket with objects
- IAM permissions to modify S3 bucket configurations

---

## 3. Basic Lifecycle Rule Example

### Objective

Move objects to S3 Standard-IA after 30 days and delete them after 365 days.

### Using AWS Console

1. Go to **S3 Dashboard** > **Your Bucket** > **Management** tab.
2. Under **Lifecycle rules**, click **Create lifecycle rule**.
3. Name the rule: `StandardToIA_DeleteAfter1Year`
4. Choose **Apply to all objects in the bucket**.
5. **Transition actions**:
   - Add Transition:
     - Days after object creation: 30
     - Storage class: `S3 Standard-IA`
6. **Expiration actions**:
   - Permanently delete objects after 365 days.
7. Click **Create rule**.

### Using AWS CLI

```json
{
  "Rules": [
    {
      "ID": "StandardToIA_DeleteAfter1Year",
      "Status": "Enabled",
      "Filter": {
        "Prefix": ""
      },
      "Transitions": [
        {
          "Days": 30,
          "StorageClass": "STANDARD_IA"
        }
      ],
      "Expiration": {
        "Days": 365
      }
    }
  ]
}
```

Apply the rule using:

```sh
aws s3api put-bucket-lifecycle-configuration \
  --bucket your-bucket-name \
  --lifecycle-configuration file://lifecycle.json
```

---

## 4. Advanced Lifecycle Rule Example

### Objective

- Transition logs to Glacier after 60 days
- Transition to Deep Archive after 180 days
- Delete incomplete multipart uploads after 7 days
- Apply rules only to objects with the prefix `logs/`

### Using AWS Console

1. Go to **S3 Dashboard** > **Your Bucket** > **Management** tab.
2. Click **Create lifecycle rule**.
3. Name: `LogsArchival`
4. Scope: Apply to objects with prefix: `logs/`
5. **Transition actions**:
   - 60 days → `GLACIER`
   - 180 days → `DEEP_ARCHIVE`
6. **Incomplete multipart uploads**:
   - Clean up uploads after 7 days
7. Click **Create rule**

### Using AWS CLI

```json
{
  "Rules": [
    {
      "ID": "LogsArchival",
      "Status": "Enabled",
      "Filter": {
        "Prefix": "logs/"
      },
      "Transitions": [
        {
          "Days": 60,
          "StorageClass": "GLACIER"
        },
        {
          "Days": 180,
          "StorageClass": "DEEP_ARCHIVE"
        }
      ],
      "AbortIncompleteMultipartUpload": {
        "DaysAfterInitiation": 7
      }
    }
  ]
}
```

Apply using:

```sh
aws s3api put-bucket-lifecycle-configuration \
  --bucket your-bucket-name \
  --lifecycle-configuration file://advanced-lifecycle.json
```

---

## 5. Real-life Use Cases

### a. Backup Management

Transition daily backups to cheaper storage tiers and delete after retention period:

- 30 days → S3 Glacier
- 90 days → Delete

### b. Data Archival (Compliance)

Keep logs for compliance in Deep Archive:

- 365 days → Deep Archive
- Retain for 7 years before deletion

### c. Dev/Test Environments

Auto-cleanup dev data:

- Prefix: `dev/`
- Delete after 15 days

---

## 6. Monitoring and Best Practices

- Use **S3 Storage Lens** to analyze object age and optimize rules
- Name rules clearly and document purpose
- Test rules with sample prefixes before applying globally
- Ensure **versioning** considerations are accounted for if enabled

---

This guide provides a comprehensive setup for S3 Lifecycle Rules from basic to advanced configurations with real-life use cases.

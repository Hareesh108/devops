# 🔐 EBS Encryption Steps (AWS)

Encrypting Amazon EBS volumes ensures your data is secure at rest and during volume snapshots or restores.

---

## ✅ Prerequisites

- AWS CLI or AWS Console access
- Appropriate IAM permissions for EC2 and EBS
- Optionally, a KMS (Key Management Service) key (AWS provides a default one)

---

## 📘 Option 1: Encrypt EBS Volume Using AWS Console

### 1. **Login to AWS Console**

   Go to [https://console.aws.amazon.com](https://console.aws.amazon.com).

### 2. **Navigate to EC2 → Volumes**

   Under **Elastic Block Store**, click on **Volumes**.

### 3. **Click “Create Volume”**

- Select volume type (gp3, gp2, etc.)
- Set size, availability zone, etc.
- Under **Encryption**, choose:
  - **Enable Encryption**
  - Select KMS key (Default or custom)

### 4. **Create Volume**

   Click **Create Volume** to proceed.

### 5. **Attach Volume to EC2**

- Select volume → **Actions → Attach Volume**
- Choose instance and device path

---

## 📘 Option 2: Encrypt EBS Volume Using AWS CLI

### 1. **Create Encrypted Volume**

\`\`\`bash
aws ec2 create-volume \
  --availability-zone us-east-1a \
  --size 20 \
  --volume-type gp3 \
  --encrypted \
  --kms-key-id alias/aws/ebs
\`\`\`

Replace `us-east-1a` with your AZ and `alias/aws/ebs` with your KMS key alias or ARN if needed.

### 2. **Attach Volume to Instance**

\`\`\`bash
aws ec2 attach-volume \
  --volume-id vol-0123456789abcdef0 \
  --instance-id i-0123456789abcdef0 \
  --device /dev/sdf
\`\`\`

---

## 📘 Option 3: Encrypt an Existing Unencrypted Volume

**You can't directly encrypt an existing volume**, but you can do it via snapshot:

### 1. **Create Snapshot of the Existing Volume**

\`\`\`bash
aws ec2 create-snapshot \
  --volume-id vol-0123456789abcdef0 \
  --description "Snapshot of unencrypted volume"
\`\`\`

### 2. **Copy Snapshot with Encryption**

\`\`\`bash
aws ec2 copy-snapshot \
  --source-region us-east-1 \
  --source-snapshot-id snap-0123456789abcdef0 \
  --encrypted \
  --kms-key-id alias/aws/ebs
\`\`\`

### 3. **Create New Volume from Encrypted Snapshot**

\`\`\`bash
aws ec2 create-volume \
  --snapshot-id snap-0fedcba9876543210 \
  --availability-zone us-east-1a \
  --encrypted \
  --volume-type gp3
\`\`\`

---

## 🔒 Notes

- Data is encrypted at rest using AES-256.
- All data copied from an encrypted volume or snapshot remains encrypted.
- You can use customer-managed KMS keys for more control.

# Creating and Managing Amazon Machine Images (AMIs) in AWS

## 1. What is an AMI?

An Amazon Machine Image (AMI) is a template used to launch EC2 instances. It includes:

- A root volume image with an operating system
- Launch permissions
- Optional instance configuration (e.g., EBS snapshots)

---

## 2. Pre-requisites

- AWS account
- IAM user/role with permissions to manage EC2 and AMIs
- Running EC2 instance (optional if creating an AMI from an instance)

---

## 3. Create an AMI from an EC2 Instance

### Using AWS Console

1. Go to **EC2 Dashboard** > **Instances**.
2. Select your running instance.
3. Click **Actions > Image and templates > Create image**.
4. Provide:
   - Image name
   - Description (optional)
   - Select volumes (root and additional EBS volumes)
   - Enable **No Reboot** (optional)
5. Click **Create image**.
6. Monitor creation under **AMIs**.

### Using AWS CLI

```sh
aws ec2 create-image \
  --instance-id i-0123456789abcdef0 \
  --name "MyCustomAMI" \
  --description "AMI from my EC2 instance" \
  --no-reboot
```

---

## 4. View and Manage AMIs

### List Owned AMIs

```sh
aws ec2 describe-images --owners self
```

### View Specific AMI Details

```sh
aws ec2 describe-images --image-ids ami-0abcdef1234567890
```

---

## 5. Launch an EC2 Instance from a Custom AMI

### Using Console

1. Go to **EC2 Dashboard** > **AMIs**.
2. Select your custom AMI.
3. Click **Launch instance**.
4. Configure instance type, storage, networking, etc.
5. Review and launch.

### Using AWS CLI

```sh
aws ec2 run-instances \
  --image-id ami-0abcdef1234567890 \
  --instance-type t2.micro \
  --key-name MyKeyPair \
  --security-group-ids sg-12345678 \
  --subnet-id subnet-12345678
```

---

## 6. Share an AMI with Other Accounts

### Using AWS Console

1. Go to **EC2 Dashboard** > **AMIs**.
2. Select your AMI.
3. Click **Actions > Modify Image Permissions**.
4. Add AWS Account ID(s) to share.
5. Click **Save**.

### Using AWS CLI

```sh
aws ec2 modify-image-attribute \
  --image-id ami-0abcdef1234567890 \
  --launch-permission "Add=[{\"UserId\":\"123456789012\"}]"
```

---

## 7. Deregister/Delete an AMI

### Using AWS Console

1. Go to **EC2 Dashboard** > **AMIs**.
2. Select the AMI.
3. Click **Actions > Deregister AMI**.

### Using AWS CLI

```sh
aws ec2 deregister-image --image-id ami-0abcdef1234567890
```

To delete associated snapshots:

```sh
aws ec2 delete-snapshot --snapshot-id snap-0abcd1234efgh5678
```

---

## 8. Automating AMI Creation with AWS Systems Manager (Optional)

Use **Automation documents** (SSM Documents) to create scheduled AMIs.

### Example SSM Document: `AWS-CreateImage`

```sh
aws ssm start-automation-execution \
  --document-name "AWS-CreateImage" \
  --parameters \
    InstanceId=i-0123456789abcdef0, \
    ImageName="ScheduledBackup-$(date +%Y%m%d)"
```

---

## 9. Best Practices

- Use **Tags** for identifying AMIs (e.g., Name, Owner, Environment).
- Regularly **clean up** unused AMIs and snapshots.
- Use **encryption** for EBS-backed AMIs.
- Integrate AMI creation into **CI/CD pipelines** for golden images.

---

This guide covers end-to-end steps for creating, managing, and automating Amazon Machine Images (AMIs) in AWS.

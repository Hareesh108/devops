# AWS Spot Instance Creation Guide

## Step 1: Configure AWS CLI

Ensure you have AWS CLI installed and configured:

```sh
aws configure
```

## Step 2: Request Spot Instance

Use the following command to request a **Spot Instance** with maximum configuration:

```sh
aws ec2 request-spot-instances \
    --instance-count 1 \
    --type "one-time" \
    --launch-specification file://spot-instance-config.json
```

## Step 3: Define Spot Instance Configuration

Create a `spot-instance-config.json` file with the following:

```json
{
    "ImageId": "ami-12345678",  
    "InstanceType": "c5.4xlarge",
    "KeyName": "my-key-pair",
    "SecurityGroupIds": ["sg-0123456789abcdef0"],
    "SubnetId": "subnet-0123456789abcdef0",
    "BlockDeviceMappings": [
        {
            "DeviceName": "/dev/xvda",
            "Ebs": {
                "VolumeSize": 100,
                "VolumeType": "gp3",
                "DeleteOnTermination": true
            }
        }
    ],
    "IamInstanceProfile": {
        "Arn": "arn:aws:iam::123456789012:instance-profile/MyInstanceProfile"
    },
    "Monitoring": {
        "Enabled": true
    },
    "Placement": {
        "AvailabilityZone": "us-east-1a"
    }
}
```

> **Note:** Replace `ami-12345678`, `subnet-0123456789abcdef0`, `sg-0123456789abcdef0`, and IAM role ARN with actual values from your AWS account.

## Step 4: Check Spot Instance Request Status

```sh
aws ec2 describe-spot-instance-requests
```

## Step 5: Get Instance ID Once Request is Fulfilled

```sh
aws ec2 describe-instances --filters "Name=instance-lifecycle,Values=spot"
```

## Step 6: SSH Into Spot Instance

```sh
ssh -i my-key-pair.pem ec2-user@<INSTANCE_PUBLIC_IP>
```

## Step 7: Terminate Spot Instance

```sh
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
```

## Additional Configurations

- **Set Spot Price Limit:** Add `"SpotPrice": "0.05"` in the `spot-instance-config.json` file.
- **Use a Persistent Request:** Change `"one-time"` to `"persistent"` in the request command.

---

# Creating a Spot Instance via AWS Console

### Step 1: Navigate to the EC2 Dashboard

1. Sign in to [AWS Management Console](https://aws.amazon.com/console/).
2. Navigate to **EC2 Dashboard** by searching "EC2" in the AWS search bar.

### Step 2: Request a Spot Instance

1. Click on **Instances** in the left menu.
2. Click **Launch an instance**.
3. Under **Instance type**, select the required instance type (e.g., `c5.4xlarge`).
4. Click **Request Spot Instances** (instead of regular on-demand instance).

### Step 3: Configure Instance Details

1. Choose an **Amazon Machine Image (AMI)**.
2. Select a **VPC and subnet** where the instance should be launched.
3. Configure **storage**, **security group**, and **IAM role** as needed.
4. Set the **Spot price** (optional) or allow AWS to choose automatically.
5. Choose a **persistent** or **one-time** request based on your needs.
6. Click **Next: Add Storage**, configure storage (e.g., `100GB gp3` volume).
7. Click **Next: Add Tags** and add tags if needed.
8. Click **Next: Configure Security Group** and allow necessary ports (e.g., `22` for SSH).

### Step 4: Review and Launch

1. Review the Spot Instance configuration.
2. Click **Launch** and select an existing **key pair** or create a new one.
3. Confirm the request and **submit**.

### Step 5: Monitor Spot Request

1. Navigate to **Spot Requests** in the EC2 dashboard.
2. Check the status of your Spot Instance request.
3. Once the request is fulfilled, go to **Instances** to find your running Spot Instance.

### Step 6: Connect to Your Spot Instance

1. Select the instance from the **Instances** page.
2. Click **Connect** and follow the instructions to SSH into the instance:

   ```sh
   ssh -i my-key-pair.pem ec2-user@<INSTANCE_PUBLIC_IP>
   ```

### Step 7: Terminate the Instance (If Needed)

1. Go to **Instances** in the EC2 Dashboard.
2. Select the Spot Instance.
3. Click **Actions > Instance State > Terminate**.

This guide ensures you can launch a fully optimized **Spot Instance** using both AWS CLI and AWS Console. 🚀

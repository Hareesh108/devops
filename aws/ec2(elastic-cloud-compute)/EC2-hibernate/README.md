# AWS EC2 Hibernate Setup (Free Tier Configuration)

## Step 1: Verify Free Tier Eligibility

Amazon Free Tier provides **750 hours/month** of EC2 usage on **t2.micro** or **t3.micro** instances. Hibernate support is available on **t3, t3a, m5, and m5a** instance types, but they are not covered under Free Tier.

> **Note:** Hibernate is not supported on `t2.micro`, so you'll need to use a small instance like `t3.small`, which incurs charges.

## Step 2: Enable Hibernate in EC2 Configuration (AWS Console)

### 1. Launch a New EC2 Instance

1. Go to the **AWS Management Console** → **EC2 Dashboard**.
2. Click **Launch an Instance**.
3. Choose an **Amazon Machine Image (AMI)** (e.g., Amazon Linux 2 or Ubuntu 22.04 LTS).
4. Select an instance type that supports hibernation (e.g., `t3.small`).

### 2. Configure Instance Details

1. Choose **Enable Hibernate** under **Advanced Details**.
2. Ensure the root volume has **at least 2x the RAM size** (minimum 8GB for hibernation).
3. Select an existing key pair or create a new one for SSH access.

### 3. Configure Storage

1. Increase the **EBS volume** size (e.g., 16GB for `t3.small`).
2. Set the **volume type** to `gp3`.
3. Enable **Delete on Termination** to clean up storage after termination.

### 4. Configure Security Group

1. Add **inbound rule** for **SSH (port 22)** to allow remote access.
2. Allow **ICMP (ping)** if needed.

### 5. Launch the Instance

1. Review the settings and click **Launch**.
2. Wait until the instance **Status Check** is complete.

## Step 3: Enable Hibernate via AWS CLI

Use AWS CLI to launch an EC2 instance with hibernation enabled.

```sh
aws ec2 run-instances \
    --image-id ami-12345678 \
    --instance-type t3.small \
    --key-name my-key \
    --security-group-ids sg-0123456789abcdef0 \
    --subnet-id subnet-0123456789abcdef0 \
    --block-device-mappings '[{"DeviceName": "/dev/xvda", "Ebs": {"VolumeSize": 16, "VolumeType": "gp3"}}]' \
    --hibernation-options Configured=true
```

## Step 4: Hibernate and Resume an EC2 Instance

### 1. Hibernate an Instance

Run the following command to put the instance into hibernation:

```sh
aws ec2 hibernate-instances --instance-ids i-1234567890abcdef0
```

### 2. Resume a Hibernated Instance

```sh
aws ec2 start-instances --instance-ids i-1234567890abcdef0
```

### 3. Check Hibernate Support for an Instance

```sh
aws ec2 describe-instances --instance-ids i-1234567890abcdef0 --query 'Reservations[*].Instances[*].[InstanceId,HibernationOptions.Configured]'
```

## Step 5: Verify Hibernate Functionality

1. SSH into the instance:

   ```sh
   ssh -i my-key.pem ec2-user@<INSTANCE_PUBLIC_IP>
   ```

2. Run a process (`top` or `htop`) and then hibernate the instance.
3. Resume the instance and check if the process is still running.

## Summary of Hibernate Requirements

| Feature | Requirement |
|---------|------------|
| **Instance Type** | t3, t3a, m5, m5a (Not Free Tier) |
| **OS Support** | Amazon Linux 2, Ubuntu 22.04, Windows |
| **EBS Volume** | At least 2x RAM size, `gp3` or `gp2` |
| **Key Configuration** | Enable Hibernate during instance creation |

This guide provides a step-by-step approach to setting up EC2 hibernation, ensuring you can pause and resume workloads efficiently. 🚀

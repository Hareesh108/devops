# AWS EBS (Elastic Block Store) Hands-on Lab

This lab demonstrates how to work with AWS EBS (Elastic Block Store) including creating, attaching, mounting, persisting, and detaching EBS volumes.

## Prerequisites

- AWS CLI configured with appropriate permissions
- EC2 instance running Linux (Amazon Linux 2 recommended)
- IAM permissions for EBS operations
- Available EBS volume quota in your AWS account

## Lab Overview

This hands-on lab covers the following EBS operations:

1. Creating an EBS volume
2. Attaching and mounting the volume to an EC2 instance
3. Persisting the volume across reboots
4. Detaching and unmounting the volume

## Step-by-Step Instructions

### Step 1: Create EBS Volume

1. **Navigate to EC2 Console**
   - Open AWS Management Console
   - Go to EC2 service
   - Click on "Volumes" in the left sidebar
   - Click "Create volume"

2. **Configure Volume Settings**
   - **Volume type**: Choose appropriate type (gp2, gp3, io1, io2, st1, sc1)
   - **Size**: Set volume size in GiB (e.g., 10 GiB)
   - **Availability Zone**: Select the same AZ as your EC2 instance
   - **Snapshot ID**: Leave blank for new volume, or select existing snapshot
   - **Encryption**: Enable encryption for sensitive data (recommended)

3. **Configure Advanced Settings**
   - **IOPS**: Set if using Provisioned IOPS (io1/io2)
   - **Throughput**: Set if using gp3 volume type
   - **Tags**: Add tags for better resource management

4. **Create Volume**
   - Review settings
   - Click "Create volume"
   - Note the volume ID for later use

### Step 2: Attach and Mount EBS Volume

1. **Attach Volume to EC2 Instance**
   - Select the created volume
   - Click "Actions" → "Attach volume"
   - Select your EC2 instance
   - Choose device name (e.g., /dev/sdf)
   - Click "Attach"

2. **Connect to EC2 Instance**

   ```bash
   ssh -i your-key.pem ec2-user@your-instance-ip
   ```

3. **Check Available Block Devices**

   ```bash
   lsblk
   ```

4. **Create File System (if new volume)**

   ```bash
   # For new volumes, create a file system
   sudo mkfs -t xfs /dev/xvdf
   # OR for ext4
   sudo mkfs -t ext4 /dev/xvdf
   ```

5. **Create Mount Point**

   ```bash
   sudo mkdir /mnt/ebs-volume
   ```

6. **Mount the Volume**

   ```bash
   sudo mount /dev/xvdf /mnt/ebs-volume
   ```

7. **Verify Mount**

   ```bash
   df -h
   mount | grep xvdf
   ```

### Step 3: Persist Volume Across Reboots

1. **Get Volume UUID**

   ```bash
   sudo blkid /dev/xvdf
   ```

2. **Edit fstab File**

   ```bash
   sudo vi  /etc/fstab
   ```

3. **Add EBS Entry to fstab**
   Add the following line to `/etc/fstab`:

   ```
   UUID=your-volume-uuid /mnt/ebs-volume xfs defaults,nofail 0 2
   ```

   Replace `your-volume-uuid` with the actual UUID from blkid command.
   Use `ext4` instead of `xfs` if you created an ext4 file system.

4. **Test fstab Configuration**

   ```bash
   sudo umount /mnt/ebs-volume
   sudo mount -a
   ```

5. **Verify Persistence**

   ```bash
   df -h
   ls -la /mnt/ebs-volume
   ```

### Step 4: Detach and Unmount Volume

1. **Unmount the Volume**

   ```bash
   sudo umount /mnt/ebs-volume
   ```

2. **Verify Unmount**

   ```bash
   df -h
   mount | grep xvdf
   ```

3. **Remove from fstab (Optional)**
   If you want to remove the automatic mount on reboot:

   ```bash
   sudo nano /etc/fstab
   # Remove or comment out the EBS line
   ```

4. **Detach Volume from EC2**
   - Go to EC2 console → Volumes
   - Select your volume
   - Click "Actions" → "Detach volume"
   - Confirm detachment

## Testing Volume Operations

### Create Test Files

```bash
# Create a test file
echo "Hello EBS!" > /mnt/ebs-volume/test.txt

# Create a directory
mkdir /mnt/ebs-volume/testdir

# List contents
ls -la /mnt/ebs-volume/
```

### Verify Data Persistence

```bash
# Unmount and remount
sudo umount /mnt/ebs-volume
sudo mount -a

# Check if data is still there
cat /mnt/ebs-volume/test.txt
ls -la /mnt/ebs-volume/
```

## EBS Volume Types

### General Purpose (SSD)

- **gp2**: Up to 16,000 IOPS, 250 MB/s throughput
- **gp3**: Up to 16,000 IOPS, 1,000 MB/s throughput (recommended)

### Provisioned IOPS (SSD)

- **io1**: Up to 64,000 IOPS, 1,000 MB/s throughput
- **io2**: Up to 64,000 IOPS, 1,000 MB/s throughput (higher durability)

### Throughput Optimized (HDD)

- **st1**: Up to 500 MB/s throughput, cannot be boot volume

### Cold (HDD)

- **sc1**: Lowest cost, cannot be boot volume

## Security Considerations

1. **Encryption**
   - Enable encryption at rest for sensitive data
   - EBS encryption uses AWS KMS

2. **IAM Permissions**
   - Use least privilege principle
   - Grant only necessary EBS permissions

3. **Security Groups**
   - EBS volumes are accessed through EC2 instances
   - Configure EC2 security groups appropriately

## Troubleshooting

### Common Issues

1. **Volume Not Appearing**
   - Check if volume is attached to correct instance
   - Verify device name mapping
   - Use `lsblk` to see all block devices

2. **Mount Fails**
   - Check if file system exists
   - Verify device name
   - Check file system type in fstab

3. **Permission Denied**
   - Check IAM permissions
   - Verify volume ownership

### Useful Commands

```bash
# Check block devices
lsblk

# Check file system type
sudo file -s /dev/xvdf

# Check mount status
mount | grep xvdf

# Check volume information
sudo fdisk -l

# View system logs
sudo dmesg | grep xvdf
```

## Cleanup

1. **Unmount Volume**

   ```bash
   sudo umount /mnt/ebs-volume
   ```

2. **Remove Mount Point**

   ```bash
   sudo rmdir /mnt/ebs-volume
   ```

3. **Detach Volume**
   - Go to EC2 console → Volumes
   - Select volume and detach

4. **Delete Volume**
   - Select detached volume
   - Click "Actions" → "Delete volume"
   - Confirm deletion

## Best Practices

1. **Volume Sizing**
   - Start with smaller volumes and expand as needed
   - Monitor usage with CloudWatch

2. **Backup Strategy**
   - Create snapshots regularly
   - Use AWS Backup for automated backups

3. **Performance**
   - Choose appropriate volume type for workload
   - Use Provisioned IOPS for consistent performance

4. **Cost Optimization**
   - Use gp3 instead of gp2 for better performance/cost ratio
   - Delete unused volumes and snapshots

## Additional Resources

- [AWS EBS Documentation](https://docs.aws.amazon.com/ebs/)
- [EBS Best Practices](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-best-practices.html)
- [EBS Volume Types](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volume-types.html)

## Notes

- EBS volumes are block-level storage devices
- Volumes can only be attached to one EC2 instance at a time
- Data persists independently of EC2 instance lifecycle
- Volumes are automatically replicated within the same AZ
- Snapshots are stored in S3 and can be used to create volumes in different AZs

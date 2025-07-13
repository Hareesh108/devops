# AWS EFS (Elastic File System) Guide

## What is EFS?

Amazon EFS (Elastic File System) is a fully managed, scalable, and elastic NFS file system for AWS Cloud and on-premises resources. It provides a simple, scalable, and fully managed elastic NFS file system for use with AWS Cloud services and on-premises resources.

### Key Characteristics

- **Fully Managed**: No file system management required
- **Scalable**: Automatically scales to petabytes of data
- **Elastic**: Pay only for the storage you use
- **Highly Available**: Data is automatically replicated across multiple AZs
- **Shared Access**: Multiple EC2 instances can access the same file system simultaneously
- **NFS Compatible**: Standard NFS v4.0 and v4.1 protocols

## When to Use EFS

### Ideal Use Cases

1. **Shared File Storage**
   - Web server content sharing
   - Application data sharing across instances
   - Development team collaboration

2. **Big Data Analytics**
   - Hadoop and Spark workloads
   - Data lake storage
   - Analytics processing

3. **Content Management**
   - Media file storage and sharing
   - Document management systems
   - Backup and archive storage

4. **Application Development**
   - Container storage for Kubernetes
   - CI/CD pipeline storage
   - Development environment sharing

5. **High-Performance Computing**
   - Scientific computing workloads
   - Financial modeling
   - Machine learning training data

### When NOT to Use EFS

- **Boot Volumes**: Cannot be used as EC2 boot volumes
- **Database Storage**: Not recommended for high-performance databases
- **Single Instance Storage**: EBS is more cost-effective for single instances
- **Frequent Small File Operations**: May have higher latency for small files

## EFS Architecture

### Core Components

1. **File System**: The primary EFS resource
2. **Mount Targets**: Network interfaces in each AZ
3. **Access Points**: Application-specific entry points
4. **Security Groups**: Network-level access control

### Network Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   AZ-A          │    │   AZ-B          │    │   AZ-C          │
│                 │    │                 │    │                 │
│ ┌─────────────┐ │    │ ┌─────────────┐ │    │ ┌─────────────┐ │
│ │Mount Target │ │    │ │Mount Target │ │    │ │Mount Target │ │
│ │10.0.1.100   │ │    │ │10.0.2.100   │ │    │ │10.0.3.100   │ │
│ └─────────────┘ │    │ └─────────────┘ │    │ └─────────────┘ │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │   EFS File      │
                    │   System        │
                    │   (Multi-AZ)    │
                    └─────────────────┘
```

## EFS Performance Modes

### General Purpose Mode

- **Use Case**: Latency-sensitive applications
- **Performance**: Sub-millisecond latencies
- **Best For**: Web servers, content management, home directories

### Max I/O Mode

- **Use Case**: High-throughput applications
- **Performance**: Higher latencies, higher throughput
- **Best For**: Big data analytics, media processing, scientific computing

## EFS Throughput Modes

### Bursting Throughput

- **Use Case**: Variable workloads
- **Performance**: Burst up to 100 MB/s per TB stored
- **Best For**: Development, testing, variable workloads

### Provisioned Throughput

- **Use Case**: Consistent high-throughput requirements
- **Performance**: Guaranteed throughput regardless of storage
- **Best For**: Production workloads with consistent I/O patterns

## Step-by-Step EFS Setup

### Step 1: Create EFS File System

1. **Navigate to EFS Console**

   ```bash
   # Using AWS CLI
   aws efs create-file-system \
     --performance-mode generalPurpose \
     --throughput-mode bursting \
     --encrypted \
     --tags Key=Name,Value=my-efs-filesystem
   ```

2. **Configure File System Settings**
   - **Performance Mode**: General Purpose or Max I/O
   - **Throughput Mode**: Bursting or Provisioned
   - **Encryption**: Enable encryption at rest
   - **Lifecycle Management**: Enable for cost optimization

### Step 2: Create Mount Targets

1. **Create Mount Target in Each AZ**

   ```bash
   # Create mount target in AZ-A
   aws efs create-mount-target \
     --file-system-id fs-xxxxxxxxx \
     --subnet-id subnet-xxxxxxxxx \
     --security-groups sg-xxxxxxxxx
   ```

2. **Configure Security Groups**
   - Allow NFS traffic (port 2049)
   - Restrict access to specific IP ranges
   - Use least privilege principle

### Step 3: Mount EFS on EC2 Instance

1. **Install EFS Client Tools**

   ```bash
   # Amazon Linux 2
   sudo yum install -y amazon-efs-utils
   
   # Ubuntu
   sudo apt-get update
   sudo apt-get install -y amazon-efs-utils
   ```

2. **Create Mount Point**

   ```bash
   sudo mkdir /mnt/efs
   ```

3. **Mount the File System**

   ```bash
   sudo mount -t efs fs-xxxxxxxxx:/ /mnt/efs
   ```

4. **Verify Mount**

   ```bash
   df -h
   mount | grep efs
   ```

### Step 4: Persist Mount Across Reboots

1. **Add to fstab**

   ```bash
   echo "fs-xxxxxxxxx:/ /mnt/efs efs defaults,_netdev 0 0" | sudo tee -a /etc/fstab
   ```

2. **Test Configuration**

   ```bash
   sudo umount /mnt/efs
   sudo mount -a
   ```

## EFS Access Points

### Creating Access Points

```bash
# Create access point
aws efs create-access-point \
  --file-system-id fs-xxxxxxxxx \
  --posix-user Uid=1000,Gid=1000 \
  --root-directory "Path=/app-data,CreationInfo={OwnerUid=1000,OwnerGid=1000,Permissions=755}"
```

### Using Access Points

```bash
# Mount using access point
sudo mount -t efs -o accesspoint=fsap-xxxxxxxxx fs-xxxxxxxxx:/ /mnt/efs
```

## Security and Compliance

### Encryption

1. **Encryption at Rest**
   - Automatically encrypted using AWS KMS
   - Cannot be disabled
   - Uses AES-256 encryption

2. **Encryption in Transit**
   - TLS 1.2 for data in transit
   - Configured at mount time

### IAM Integration

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:DescribeFileSystems",
        "elasticfilesystem:DescribeMountTargets"
      ],
      "Resource": "*"
    }
  ]
}
```

### VPC and Network Security

1. **Security Groups**

   ```bash
   # Allow NFS traffic
   aws ec2 authorize-security-group-ingress \
     --group-id sg-xxxxxxxxx \
     --protocol tcp \
     --port 2049 \
     --source-group sg-xxxxxxxxx
   ```

2. **Network ACLs**
   - Configure network ACLs for additional security
   - Allow port 2049 for NFS traffic

## Performance Optimization

### Best Practices

1. **Choose Appropriate Performance Mode**
   - General Purpose for latency-sensitive apps
   - Max I/O for high-throughput workloads

2. **Optimize Throughput**
   - Use Provisioned Throughput for consistent workloads
   - Monitor bursting credits for variable workloads

3. **File System Optimization**
   - Use appropriate file sizes
   - Avoid excessive small files
   - Use parallel I/O operations

### Monitoring Performance

```bash
# Check EFS metrics
aws cloudwatch get-metric-statistics \
  --namespace AWS/EFS \
  --metric-name ClientConnections \
  --dimensions Name=FileSystemId,Value=fs-xxxxxxxxx \
  --start-time 2023-01-01T00:00:00Z \
  --end-time 2023-01-01T23:59:59Z \
  --period 3600 \
  --statistics Average
```

## Cost Optimization

### Pricing Model

1. **Storage Pricing**
   - Pay per GB stored
   - No minimum storage requirement
   - Lifecycle management for cost savings

2. **Throughput Pricing**
   - Bursting: Included with storage
   - Provisioned: Additional per-MB/s charge

3. **Data Transfer**
   - Free within same AZ
   - Charges for cross-AZ data transfer

### Cost Optimization Strategies

1. **Enable Lifecycle Management**

   ```bash
   aws efs put-lifecycle-configuration \
     --file-system-id fs-xxxxxxxxx \
     --lifecycle-policies '[{"TransitionToIA":"AFTER_30_DAYS"}]'
   ```

2. **Use Appropriate Throughput Mode**
   - Bursting for variable workloads
   - Provisioned for consistent high throughput

3. **Monitor and Optimize**
   - Use CloudWatch metrics
   - Implement automated cleanup
   - Regular cost reviews

## Common Use Cases and Examples

### Example 1: Web Server Content Sharing

```bash
#!/bin/bash
# Mount EFS for web content sharing

# Mount EFS
sudo mount -t efs fs-xxxxxxxxx:/ /var/www/html

# Set permissions
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Configure Apache to use EFS
echo "DocumentRoot /var/www/html" | sudo tee -a /etc/httpd/conf/httpd.conf
```

### Example 2: Container Storage for Kubernetes

```yaml
# EFS CSI Driver configuration
apiVersion: v1
kind: PersistentVolume
metadata:
  name: efs-pv
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  storageClassName: efs-sc
  csi:
    driver: efs.csi.aws.com
    volumeHandle: fs-xxxxxxxxx
```

### Example 3: Data Processing Pipeline

```python
import os
import pandas as pd

# Mount point for EFS
efs_mount = '/mnt/efs'

# Process data from EFS
def process_data():
    input_path = os.path.join(efs_mount, 'input')
    output_path = os.path.join(efs_mount, 'output')
    
    # Read data from EFS
    data = pd.read_csv(os.path.join(input_path, 'data.csv'))
    
    # Process data
    processed_data = data.groupby('category').sum()
    
    # Write results to EFS
    processed_data.to_csv(os.path.join(output_path, 'results.csv'))
```

## Troubleshooting

### Common Issues

1. **Mount Fails**

   ```bash
   # Check EFS client tools
   rpm -qa | grep efs-utils
   
   # Check mount target status
   aws efs describe-mount-targets --file-system-id fs-xxxxxxxxx
   
   # Check security groups
   aws ec2 describe-security-groups --group-ids sg-xxxxxxxxx
   ```

2. **Performance Issues**

   ```bash
   # Check network connectivity
   ping mount-target-ip
   
   # Monitor I/O performance
   iostat -x 1
   
   # Check EFS metrics
   aws cloudwatch get-metric-statistics \
     --namespace AWS/EFS \
     --metric-name PercentIOLimit \
     --dimensions Name=FileSystemId,Value=fs-xxxxxxxxx
   ```

3. **Permission Issues**

   ```bash
   # Check file permissions
   ls -la /mnt/efs
   
   # Check user/group mapping
   id
   
   # Verify access point configuration
   aws efs describe-access-points --file-system-id fs-xxxxxxxxx
   ```

### Useful Commands

```bash
# List EFS file systems
aws efs describe-file-systems

# Check mount targets
aws efs describe-mount-targets --file-system-id fs-xxxxxxxxx

# Monitor EFS performance
aws cloudwatch get-metric-statistics \
  --namespace AWS/EFS \
  --metric-name ClientConnections \
  --dimensions Name=FileSystemId,Value=fs-xxxxxxxxx

# Check EFS logs
sudo tail -f /var/log/amazon/efs/mount.log
```

## Backup and Recovery

### EFS Backup Strategies

1. **AWS Backup Integration**

   ```bash
   # Create backup plan
   aws backup create-backup-plan \
     --backup-plan '{
       "BackupPlanName": "EFS-Backup-Plan",
       "Rules": [
         {
           "RuleName": "DailyBackups",
           "TargetBackupVault": "Default",
           "ScheduleExpression": "cron(0 5 ? * * *)"
         }
       ]
     }'
   ```

2. **Manual Snapshots**

   ```bash
   # Create snapshot
   aws efs create-snapshot --file-system-id fs-xxxxxxxxx
   
   # Restore from snapshot
   aws efs create-file-system \
     --performance-mode generalPurpose \
     --encrypted \
     --source-file-system-id fs-xxxxxxxxx \
     --source-file-system-snapshot-id snap-xxxxxxxxx
   ```

## Best Practices

### Architecture Best Practices

1. **Multi-AZ Deployment**
   - Create mount targets in multiple AZs
   - Use for high availability

2. **Security Best Practices**
   - Enable encryption at rest and in transit
   - Use security groups to restrict access
   - Implement least privilege access

3. **Performance Best Practices**
   - Choose appropriate performance and throughput modes
   - Monitor performance metrics
   - Optimize file sizes and access patterns

### Operational Best Practices

1. **Monitoring**
   - Set up CloudWatch alarms
   - Monitor performance metrics
   - Track cost and usage

2. **Maintenance**
   - Regular security updates
   - Performance optimization
   - Cost reviews

3. **Documentation**
   - Document mount procedures
   - Maintain runbooks
   - Update procedures regularly

## Additional Resources

- [AWS EFS Documentation](https://docs.aws.amazon.com/efs/)
- [EFS Best Practices](https://docs.aws.amazon.com/efs/latest/ug/best-practices.html)
- [EFS Performance](https://docs.aws.amazon.com/efs/latest/ug/performance.html)
- [EFS Security](https://docs.aws.amazon.com/efs/latest/ug/security.html)
- [EFS Pricing](https://aws.amazon.com/efs/pricing/)

## Conclusion

EFS provides a scalable, managed file system solution for AWS workloads. Understanding its features, performance characteristics, and best practices is essential for successful implementation. Proper planning, monitoring, and optimization can ensure optimal performance and cost-effectiveness.

### Key Takeaways

1. **Choose appropriate performance and throughput modes**
2. **Implement proper security measures**
3. **Monitor performance and costs**
4. **Use access points for application-specific access**
5. **Plan for backup and disaster recovery**

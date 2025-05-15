# Amazon Database Migration Service (DMS)

## Overview

Amazon Database Migration Service (DMS) is a cloud service that enables you to migrate databases to AWS quickly and securely. The source database remains fully operational during the migration, minimizing downtime.

## Real-World Example

Let's consider a scenario where an e-commerce company wants to migrate their on-premises Oracle database to Amazon Aurora PostgreSQL:

**Company: GlobalShop Inc.**

- Current setup: On-premises Oracle 12c database (2TB)
- Target: Aurora PostgreSQL
- Requirement: Minimal downtime during business hours

### Solution Architecture

```
[On-premises Oracle DB] → [DMS Replication Instance] → [Aurora PostgreSQL]
                              ↓
                     [AWS Schema Conversion Tool]
```

## Key Components

1. **Replication Instance**
   - EC2 instance that runs the migration tasks
   - Performs the actual data movement between source and target

2. **Source and Target Endpoints**
   - Connection information for source and target databases
   - Supported sources: Oracle, MySQL, PostgreSQL, MongoDB, etc.
   - Supported targets: Amazon RDS, Aurora, Redshift, etc.

3. **Database Migration Task**
   - Defines what tables to migrate
   - Specifies the type of migration (full load/CDC)

## Migration Types

1. **Full Load**
   - One-time migration of all data
   - Best for dev/test environments

2. **Full Load + CDC (Change Data Capture)**
   - Initial full load followed by continuous replication
   - Ideal for production migrations

3. **CDC Only**
   - Only replicates ongoing changes
   - Used for continuous replication scenarios

## Best Practices

1. **Pre-migration:**
   - Validate database compatibility
   - Use AWS Schema Conversion Tool (SCT)
   - Size replication instance appropriately

2. **During Migration:**
   - Monitor task progress
   - Check CloudWatch metrics
   - Validate data accuracy

3. **Post-migration:**
   - Compare source and target data
   - Test application functionality
   - Switch application connectivity

## Cost Considerations

- Replication instance costs (per hour)
- Data transfer costs
- Storage costs for logs

## Example Migration Timeline

1. Setup (Day 1)
   - Create replication instance
   - Configure endpoints

2. Initial Load (Day 2-3)
   - Full data transfer
   - Initial validation

3. CDC Phase (Day 4-7)
   - Capture ongoing changes
   - Application testing

4. Cutover (Day 8)
   - Final validation
   - DNS switch
   - Application configuration update

## Monitoring and Troubleshooting

- CloudWatch metrics
- AWS DMS console
- Task logs and events
- Replication instance logs

## Security

- Encryption at rest using KMS
- Encryption in transit using SSL
- IAM roles and permissions
- VPC security groups

## Limitations

- Max table size: 6TB
- Some data types not supported
- Schema conversion limitations

For detailed documentation, visit [AWS DMS Documentation](https://docs.aws.amazon.com/dms/)

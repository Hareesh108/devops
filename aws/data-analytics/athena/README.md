# Amazon Athena Documentation

## Overview

Amazon Athena is a serverless, interactive query service that enables you to analyze data directly in Amazon S3 using standard SQL.

## Key Features

- Serverless: No infrastructure to manage
- Pay-per-query: Only pay for the queries you run
- Standard SQL: Uses Presto engine with ANSI SQL support
- Direct S3 Integration: Query data stored in S3 without loading

## Real-World Example: Log Analysis

### Scenario

A retail company needs to analyze their web application logs stored in S3 to understand user behavior.

### Architecture

```
[Web Application] 
    ↓
[CloudWatch Logs]
    ↓
[Kinesis Firehose]
    ↓
[Amazon S3 (Raw Logs)]
    ↓
[Amazon Athena] → [QuickSight]
```

### Implementation Steps

1. Store logs in S3 with partitioning:

```
s3://company-logs/year=2023/month=12/day=01/logs.json
```

2. Create Athena table:

```sql
CREATE EXTERNAL TABLE web_logs (
    timestamp STRING,
    user_id STRING,
    page_url STRING,
    action STRING
)
PARTITIONED BY (year STRING, month STRING, day STRING)
STORED AS JSON
LOCATION 's3://company-logs/';
```

3. Query example:

```sql
SELECT action, COUNT(*) as count
FROM web_logs
WHERE year='2023' AND month='12'
GROUP BY action
ORDER BY count DESC;
```

## Best Practices

1. Partition data appropriat

- Use CTAS (Create Table As Select) for frequently used datasets

## Common Use Cases

1. Log Analysis
2. Business Intelligence
3. Data Lake Queries
4. Ad-hoc Analysis
5. ETL Job Creation

## Integration Points

- AWS QuickSight for visualization
- AWS Glue for ETL
- Amazon S3 for storage
- AWS Lambda for automation
- Amazon SageMaker for ML pipelines

## Limitations

- Query timeout: 30 minutes
- Max query string length: 256KB
- Concurrent queries: 20 per account
- Results retained for 24 hours
ely

2. Compress files (use Snappy or GZIP)
3. Use columnar formats (Parquet or ORC)
4. Optimize table layouts
5. Use AWS Glue Data Catalog

## Cost Optimization

- Current pricing: $5 per TB of data scanned
- Implement partitioning to reduce scan size
- Convert to columnar format

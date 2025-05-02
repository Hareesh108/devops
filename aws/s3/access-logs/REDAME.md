# AWS S3 Access Logging with Athena Analysis

## Setting up S3 Access Logging

1. **Enable Server Access Logging**

    ```bash
    aws s3api put-bucket-logging \
         --bucket source-bucket \
         --bucket-logging-status file://logging.json
    ```

2. **Create Target Bucket**
    - Create a separate bucket for logs
    - Ensure proper permissions
    - Recommended prefix: `logs/`

3. **Required Permissions**

    ```json
    {
         "Version": "2012-10-17",
         "Statement": [
              {
                    "Effect": "Allow",
                    "Principal": {
                         "Service": "logging.s3.amazonaws.com"
                    },
                    "Action": "s3:PutObject",
                    "Resource": "arn:aws:s3:::target-bucket/*"
              }
         ]
    }
    ```

## Amazon Athena Overview

Amazon Athena is a serverless query service that enables analysis of S3 data using standard SQL.

### Key Features

- Serverless: Pay only for queries run
- Uses Presto under the hood
- Supports various file formats (CSV, JSON, Parquet)
- Direct integration with S3

### Setting up Athena for Log Analysis

1. **Create Table**

    ```sql
    CREATE EXTERNAL TABLE s3_access_logs (
         bucketowner STRING,
         bucket STRING,
         requestdatetime STRING,
         remoteip STRING,
         requester STRING,
         requestid STRING,
         operation STRING,
         key STRING,
         request_uri STRING,
         httpstatus STRING,
         errorcode STRING,
         bytessent BIGINT,
         objectsize BIGINT,
         totaltime STRING,
         turnaroundtime STRING,
         referrer STRING,
         useragent STRING,
         versionid STRING
    )
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
    WITH SERDEPROPERTIES (
         'input.regex' = '([^ ]*) ([^ ]*) \\[(.*?)\\] ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\") ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\") (\"[^\"]*\")(.*)'
    )
    LOCATION 's3://your-log-bucket/logs/';
    ```

2. **Sample Queries**

    ```sql
    -- Most accessed objects
    SELECT key, COUNT(*) as count
    FROM s3_access_logs
    GROUP

# Resource-Based Policies in AWS IAM

## Overview

Resource-based policies are IAM policies attached directly to AWS resources (like S3 buckets, SQS queues, etc.) rather than IAM users or roles. They control who can access the resource and what actions they can perform.

## Architecture

```
┌────────────────┐      ┌────────────────┐
│   IAM Users/   │      │  AWS Resource  │
│     Roles      ├─────►│  (e.g., S3)    │
└────────────────┘      │  with Policy   │
                        └────────────────┘
```

## Real-World Example: Multi-Team S3 Access

### Scenario

A company has three teams:

- Development Team (needs read/write access)
- Audit Team (needs read-only access)
- External Partners (needs limited write access)

### Implementation

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::123456789012:role/DevelopmentTeam"
            },
            "Action": ["s3:GetObject", "s3:PutObject"],
            "Resource": "arn:aws:s3:::company-data/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::123456789012:role/AuditTeam"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::company-data/*"
        }
    ]
}
```

## Key Benefits

1. Centralized access control
2. Fine-grained permissions
3. Cross-account access management
4. Simplified auditing

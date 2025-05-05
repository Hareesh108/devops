# Amazon DocumentDB (with MongoDB compatibility)

## Overview

Amazon DocumentDB is a fully managed, MongoDB-compatible document database service that supports workloads from single-instance dev/test environments to large-scale mission-critical applications.

## Key Features

- MongoDB 4.0 API compatibility
- Automatic scaling from 10GB to 64TB
- Millisecond latency
- High availability with 3 replicas across AZs
- Automated backups and point-in-time recovery

## Architecture

```
┌────────────────────┐     ┌─────────────────┐
│    Application     │────▶│   DocumentDB    │
└────────────────────┘     │   Cluster       │
                          └─────────────────┘
                                  │
                    ┌─────────────┼─────────────┐
                    ▼             ▼             ▼
              ┌─────────┐   ┌─────────┐   ┌─────────┐
              │Replica 1│   │Replica 2│   │Replica 3│
              └─────────┘   └─────────┘   └─────────┘
                 AZ-1         AZ-2         AZ-3
```

## Real-World Example

### E-commerce Product Catalog

```javascript
// Sample document structure
{
  "product_id": "P123",
  "name": "Wireless Headphones",
  "price": 99.99,
  "category": "Electronics",
  "specifications": {
    "brand": "AudioTech",
    "color": "Black",
    "battery_life": "20 hours"
  },
  "reviews": [
    {
      "user_id": "U789",
      "rating": 5,
      "comment": "Great sound quality!"
    }
  ]
}
```

## Common Use Cases

1. Content Management Systems
2. Gaming Applications
3. Real-time Big Data Applications
4. IoT Device Data Storage

## Getting Started

```bash
# Connect using MongoDB shell
mongosh --host your-cluster.cluster-xxxxxxxxxxxx.region.docdb.amazonaws.com:27017 \
        --ssl \
        --username <username> \
        --password <password>
```

## Best Practices

- Use appropriate instance sizes
- Implement proper indexing
- Enable encryption at rest
- Monitor performance metrics
- Regular backup verification

## Security

- VPC security groups
- IAM authentication
- TLS encryption in transit
- KMS encryption at rest

For more information, visit [Amazon DocumentDB Documentation](https://docs.aws.amazon.com/documentdb/)

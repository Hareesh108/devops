# Amazon Key Management Service (KMS) - Secure Key Management

## Overview

Amazon KMS is a managed service that makes it easy to create and control the encryption keys used to encrypt your data. It provides a highly available key management system that integrates with most AWS services and applications.

## Key Concepts

### 1. Customer Master Keys (CMK)

- **Managed Keys**: AWS managed keys (free)
- **Customer Managed Keys**: Created and managed by customers ($1/month)
- **Custom Key Store**: Keys stored in AWS CloudHSM

### 2. Key Types

- **Symmetric Keys**: Single key for encryption/decryption
- **Asymmetric Keys**: Public/private key pairs for encrypt/decrypt or sign/verify

## Real-World Example

Consider an e-commerce application storing sensitive customer data:

```plaintext
Customer Data -> KMS Encryption -> Amazon S3
```

### Implementation Example

```python
# Encrypting data using KMS
import boto3

kms = boto3.client('kms')

# Encrypt customer credit card data
encrypted_data = kms.encrypt(
    KeyId='arn:aws:kms:region:account:key/key-id',
    Plaintext='sensitive-data'
)

# Store encrypted data in S3
s3.put_object(
    Bucket='my-secure-bucket',
    Key='customer-data',
    Body=encrypted_data['CiphertextBlob']
)
```

## Architecture Diagram

```
┌────────────────┐     ┌─────────────┐     ┌──────────────┐
│  Application   │────>│  AWS KMS    │────>│ AWS Services │
└────────────────┘     └─────────────┘     └──────────────┘
        │                     │                    │
        │                     │                    │
        v                     v                    v
┌────────────────┐     ┌─────────────┐     ┌──────────────┐
│   Encryption   │     │  Key Store  │     │ Encrypted    │
│   Operations   │     │             │     │ Data Storage │
└────────────────┘     └─────────────┘     └──────────────┘
```

## Key Features

1. **Centralized Key Management**
   - Create, import, rotate, disable, and delete keys
   - Define key policies and grants

2. **Integration with AWS Services**
   - S3, RDS, DynamoDB
   - EBS volume encryption
   - Lambda environment variables

3. **Security Controls**
   - IAM policies
   - Key policies
   - Audit capability with CloudTrail

## Best Practices

1. **Rotate Keys Regularly**
   - Enable automatic key rotation
   - Manual rotation for specific use cases

2. **Monitor KMS Usage**
   - Use CloudWatch metrics
   - Enable CloudTrail logging

3. **Access Control**
   - Implement least privilege access
   - Use separate keys for different applications

## Pricing

- **Per-API call**: $0.03 per 10,000 requests
- **Customer managed CMK**: $1/month
- **AWS managed CMK**: Free

## Common Use Cases

1. **Data Encryption at Rest**
   - Database encryption
   - File storage encryption

2. **Digital Signatures**
   - Code signing
   - Document signing

3. **Envelope Encryption**
   - Large data encryption
   - Efficient key management

For more information, visit [AWS KMS Documentation](https://aws.amazon.com/kms/)

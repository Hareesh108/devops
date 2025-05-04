# Amazon Simple Queue Service (SQS)

## Overview

Amazon SQS is a fully managed message queuing service that enables decoupling and scaling of distributed systems and applications.

## Real-World Example: E-commerce Order Processing

### Scenario

An e-commerce platform handling thousands of orders per hour needs to:

- Process orders reliably
- Handle traffic spikes during sales
- Ensure no orders are lost
- Process orders asynchronously

### Architecture Diagram

```
[Web App] → [SQS Queue] → [Order Processing Workers]
    ↑                            ↓
[Mobile App]               [Payment System]
                           ↓
                     [Inventory System]
                           ↓
                     [Shipping Service]
```

## Key Components

### 1. Queue Types

- **Standard Queue**
  - At-least-once delivery
  - Best-effort ordering
  - Unlimited throughput
- **FIFO Queue**
  - Exactly-once processing
  - First-in-first-out delivery
  - 300 TPS limit

### 2. Core Features

- Message retention up to 14 days
- Visibility timeout
- Dead-letter queues
- Long polling
- Message attributes
- Server-side encryption

## Implementation Example

```python
import boto3

# Create SQS client
sqs = boto3.client('sqs')

# Send message
response = sqs.send_message(
    QueueUrl='https://sqs.region.amazonaws.com/123456789012/MyQueue',
    MessageBody='Order #123 received'
)

# Receive message
messages = sqs.receive_message(
    QueueUrl='https://sqs.region.amazonaws.com/123456789012/MyQueue',
    MaxNumberOfMessages=1
)
```

## Best Practices

1. Use dead-letter queues for failed messages
2. Implement proper error handling
3. Set appropriate visibility timeout
4. Use batch operations for better throughput
5. Monitor queue metrics

## Common Use Cases

- Order processing
- Image/video processing
- Email sending
- Task distribution
- Microservices communication

## Pricing

- Pay per request
- Free tier available
- No upfront costs
- Charges based on requests and data transfer

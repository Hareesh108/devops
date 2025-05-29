# AWS Billing and Pricing Documentation

## Overview

Amazon Web Services (AWS) provides a pay-as-you-go pricing model where you only pay for the services you consume. This document explains key billing concepts and pricing strategies.

## Key Billing Components

### 1. Cost Explorer

- Visual tool to track and analyze AWS spending
- Filter costs by service, region, tags
- Create custom reports and forecasts

### 2. AWS Free Tier

- Includes 12 months free for new customers
- Examples:
  - 750 hours/month of t2.micro EC2 instance
  - 5GB of S3 storage
  - 1 million Lambda requests

### 3. Billing Methods

#### Pay-As-You-Go

```
Example:
EC2 t3.micro in us-east-1: $0.0104 per hour
Monthly usage: 720 hours
Cost = $0.0104 × 720 = $7.48
```

#### Reserved Instances (RI)

```
Example:
On-demand t3.large: $0.0832/hour
1-year RI with upfront: $0.0499/hour
Savings: 40% ($241.63/year)
```

## Architecture Example

```plaintext
                                                                        AWS Organization
                                                                                     │
                                        ┌──────────────────────┴───────────────────┐
                                        │                                          │
                            Master Account                           Member Accounts
                                        │                                     │
                 ┌──────────┴──────────┐                 ┌───────┴────────┐
                 │                     │                 │                │
        Cost Explorer        Billing Alerts     Cost Centers    Project Tags
                 │                     │                 │                │
        ┌────┴─────┐        ┌─────┴────┐     ┌─────┴─────┐   ┌─────┴─────┐
        │ Reports  │        │ SNS       │     │ Budget    │   │ Resource  │
        │ Analysis │        │ Email     │     │ Controls  │   │ Tracking  │
        └──────────┘        └──────────┘     └───────────┘   └───────────┘
```

## Best Practices

1. **Tag Resources**
     - Example: `Environment = Production`
     - Example: `Project = WebApp`

2. **Set Budgets**

     ```
     Monthly Budget: $1000
     Alert at: 80% ($800)
     Alert at: 100% ($1000)
     ```

3. **Use Cost Allocation Tags**
     - Track department spending
     - Monitor project costs

## Cost Optimization Strategies

1. **Right Sizing**

     ```
     Before: 5 × m5.xlarge instances
     After: 3 × m5.large instances
     Savings: ~40%
     ```

2. **Savings Plans**
     - Commit to $100/hour for 1 year
     - Save up to 72% compared to on-demand

3. **Spot Instances**

     ```
     On-demand price: $0.10/hour
     Spot price: $0.03/hour
     Savings: 70%
     ```

## Tools for Monitoring

- AWS Cost and Usage Report
- AWS Budgets
- CloudWatch Billing Alarms
- AWS Cost Anomaly Detection

## Additional Resources

- [AWS Pricing Calculator](https://calculator.aws/)
- [AWS Cost Management](https://aws.amazon.com/aws-cost-management/)
- [AWS Billing Documentation](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/Welcome.html)

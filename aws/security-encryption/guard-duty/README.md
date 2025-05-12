# Amazon GuardDuty - Intelligent Threat Detection

## Overview

Amazon GuardDuty is a threat detection service that continuously monitors AWS accounts and workloads for malicious activity and unauthorized behavior.

## How GuardDuty Works

![GuardDuty Architecture](https://d1.awsstatic.com/products/GuardDuty/Product-Page-Diagram_Amazon-GuardDuty%402x.457b2d0e4acc78435331fca3560dfae593cf4539.png)

1. **Data Sources**
    - VPC Flow Logs
    - AWS CloudTrail Events
    - DNS Logs
    - S3 Logs
    - EKS Audit Logs

2. **Analysis**
    - Machine Learning
    - Anomaly Detection
    - Integrated Threat Intelligence

## Real-World Example

### Scenario: Cryptocurrency Mining Attack Detection

```
Event: GuardDuty detects EC2 instance communicating with known cryptocurrency mining pool
Action: Automatic notification via SNS and Lambda remediation
```

### Implementation Steps

1. Enable GuardDuty

```bash
aws guardduty create-detector --enable
```

2. Configure Findings

```bash
aws guardduty update-detector \
     --detector-id <detector-id> \
     --finding-publishing-frequency FIFTEEN_MINUTES
```

## Common Findings

1. **CryptoCurrency:EC2/BitcoinTool.B**
    - Bitcoin mining activity detected

2. **Recon:IAMUser/TorIPCaller**
    - API calls from Tor exit nodes

3. **UnauthorizedAccess:EC2/SSHBruteForce**
    - SSH brute force attacks

## Best Practices

- Enable multi-account coverage
- Set up automated responses
- Regular review of findings
- Integration with Security Hub
- Custom threat lists management

## Cost Considerations

- Pricing based on analyzed log volume
- Free tier available for first 30 days
- Consider log retention settings

## Integration Example

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Resources:
  GuardDutyDetector:
     Type: 'AWS::GuardDuty::Detector'
     Properties:
        Enable: true
        FindingPublishingFrequency: FIFTEEN_MINUTES
```

## Additional Resources

- [AWS GuardDuty Documentation](https://docs.aws.amazon.com/guardduty/)
- [Security Best Practices](https://docs.aws.amazon.com/guardduty/latest/ug/security-best-practices.html)
- [API Reference](https://docs.aws.amazon.com/guardduty/latest/APIReference/)

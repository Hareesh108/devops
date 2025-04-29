# AWS Route 53 - Domain Name System (DNS)

## Overview

Amazon Route 53 is a highly available and scalable Domain Name System (DNS) web service. It performs three main functions:

- Domain registration
- DNS routing
- Health checking

## Key Features

- Global service (not region-specific)
- Highly available and reliable
- Cost-effective
- Scales automatically
- Integrates with other AWS services

## Common DNS Record Types

1. **A Record** - Maps hostname to IPv4
2. **AAAA Record** - Maps hostname to IPv6
3. **CNAME** - Maps hostname to another hostname
4. **NS** - Name servers for the hosted zone
5. **SOA** - Start of Authority
6. **MX** - Mail exchange records
7. **TXT** - Text records

## Practical Example: Setting up "hareesh.is-a.dev"

### Step 1: Domain Registration

```bash
# Note: is-a.dev is a free domain for developers
# Register through https://is-a.dev
```

### Step 2: Create Hosted Zone

1. Go to Route 53 console
2. Create hosted zone

```
Domain name: hareesh.is-a.dev
Type: Public hosted zone
```

### Step 3: Configure DNS Records

```yaml
# A Record Example
Name: hareesh.is-a.dev
Type: A
Value: <your-server-ip>

# CNAME Example (for www subdomain)
Name: www.hareesh.is-a.dev
Type: CNAME
Value: hareesh.is-a.dev
```

### Step 4: Update Name Servers

Configure the following nameservers at is-a.dev:

```
ns-1234.awsdns-12.org
ns-567.awsdns-34.com
ns-890.awsdns-56.net
ns-123.awsdns-78.co.uk
```

## Routing Policies

1. **Simple Routing**
    - Default policy
    - Multiple values = random selection

2. **Weighted Routing**

```yaml
record1:
  weight: 70%
  endpoint: us-east-1
record2:
  weight: 30%
  endpoint: us-west-2
```

3. **Latency-based**
4. **Geolocation**
5. **Failover**
6. **Multi-value**

## Health Checks

```yaml
Health Check Configuration:
  Protocol: HTTP/HTTPS/TCP
  Port: 80/443
  Path: /health
  Interval: 30 seconds
  Failure threshold: 3
```

## Cost Estimation (Monthly)

- Hosted Zone: $0.50/hosted zone/month
- DNS Queries:
  - First 1B queries: $0.40/million queries
  - Over 1B queries: $0.20/million queries
- Health Checks: $0.50/health check/month

## Best Practices

1. Use aliases for AWS resources
2. Enable health checks for critical endpoints
3. Implement appropriate routing policies
4. Regular monitoring and logging
5. Use private hosted zones for internal resources

## CLI Commands

```bash
# Create hosted zone
aws route53 create-hosted-zone --name hareesh.is-a.dev --caller-reference 2023-01-01

# List hosted zones
aws route53 list-hosted-zones

# Create record set
aws route53 change-resource-record-sets --hosted-zone-id ZXXXXXXXXXXXXXX --change-batch file://change-batch.json
```

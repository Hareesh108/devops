# AWS VPN Setup Guide

## 1. Pre-requisites

Before setting up AWS VPN, ensure you have:

- An AWS account
- AWS CLI installed and configured (`aws configure`)
- A Virtual Private Cloud (VPC) set up
- A customer gateway (On-Premise Router or Firewall with a static IP)

## 2. Create a Virtual Private Gateway (VGW)

### Using AWS Console

1. Navigate to **VPC Dashboard**.
2. Click **Virtual Private Gateways**.
3. Click **Create Virtual Private Gateway**.
4. Provide a **Name** and select **Amazon Default ASN**.
5. Click **Create Virtual Private Gateway**.
6. Attach the VGW to a VPC:
   - Select the created VGW.
   - Click **Actions > Attach to VPC**.
   - Choose your VPC and attach.

### Using AWS CLI

```sh
aws ec2 create-vpn-gateway --type ipsec.1
```

Attach it to a VPC:

```sh
aws ec2 attach-vpn-gateway --vpn-gateway-id vgw-12345678 --vpc-id vpc-87654321
```

## 3. Create a Customer Gateway

### Using AWS Console

1. Navigate to **VPC Dashboard** > **Customer Gateways**.
2. Click **Create Customer Gateway**.
3. Provide:
   - **Name** (e.g., `OnPremiseGateway`)
   - **Routing**: Static or Dynamic (BGP)
   - **IP Address**: Public static IP of the on-premise device
4. Click **Create Customer Gateway**.

### Using AWS CLI

```sh
aws ec2 create-customer-gateway --type ipsec.1 --public-ip YOUR_PUBLIC_IP --bgp-asn 65000
```

## 4. Create a VPN Connection

### Using AWS Console

1. Navigate to **VPC Dashboard** > **Site-to-Site VPN Connections**.
2. Click **Create VPN Connection**.
3. Provide:
   - **Name**
   - **Virtual Private Gateway (VGW)**
   - **Customer Gateway** (Created earlier)
   - **Routing type** (Static or Dynamic BGP)
4. Click **Create VPN Connection**.
5. Download the configuration file for your router.

### Using AWS CLI

```sh
aws ec2 create-vpn-connection \
  --type ipsec.1 \
  --customer-gateway-id cgw-12345678 \
  --vpn-gateway-id vgw-12345678 \
  --options TunnelOptions={TunnelInsideCidr=169.254.10.0/30}
```

## 5. Configure On-Premise VPN Device

- Use the downloaded configuration file to set up the VPN on your router/firewall.
- Ensure IPsec, IKE, and BGP settings match AWS.

## 6. Verify VPN Connection

Check VPN tunnel status:

```sh
aws ec2 describe-vpn-connections
```

In AWS Console:

- Navigate to **VPC Dashboard** > **Site-to-Site VPN Connections**.
- Check the **Tunnel Status** (should be **Up**).

## 7. Next Steps

- Configure **Route Tables** to allow traffic over the VPN.
- Enable **CloudWatch Logs** for monitoring VPN activity.
- Set up **AWS Direct Connect** for high-speed connections.

---
This guide covers setting up AWS VPN for secure on-premise to AWS connectivity.

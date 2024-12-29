
# VPC (Virtual Private Cloud)

Login aws account and search for VPC then select that service.

## Go to the VPC and Select create Subnet

- Select VPC id:  (whatever you created VPC)
- We are creating two subnet 1. ```public-subnet``` 2. ```private-subnet```
- Name : ```public-subnet```
- Select the Availability Zone.
- IPv4 subnet CIDR block (add manual address) ```10.0.0.1/24```
- After creating above subnet use actions option and select Edit subnet settings.
- Check mark the Auto-assign IP settings.
- Name : ```private-subnet```
- Select the Availability Zone.
- IPv4 subnet CIDR block (add manual address) ```10.0.1.0/24```

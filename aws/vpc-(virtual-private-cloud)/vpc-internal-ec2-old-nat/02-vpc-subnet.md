
# VPC (Virtual Private Cloud)

Login aws account and search for VPC then select that service.

## Go to the VPC and Select create Subnet

- Select VPC id:  (whatever you created VPC)
- We are creating two subnet 1. ```public-subnet``` 2. ```private-subnet```
- Name : ```public-subnet-a```
- Select the Availability Zone.
- IPv4 subnet CIDR block (add manual address) ```10.0.0.0/24```
- Name : ```public-subnet-b```
- Select the Availability Zone.
- IPv4 subnet CIDR block (add manual address) ```10.0.1.0/24```
- After creating above subnet use actions option and select Edit subnet settings.
- Check mark the Auto-assign IP settings.
- Name : ```private-subnet-a```
- Select the Availability Zone.
- IPv4 subnet CIDR block (add manual address) ```10.0.16.0/20```
- Name : ```private-subnet-b```
- Select the Availability Zone.
- IPv4 subnet CIDR block (add manual address) ```10.0.32.0/20```

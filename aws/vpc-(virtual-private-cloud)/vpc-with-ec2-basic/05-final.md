
# VPC (Virtual Private Cloud) and EC2 (Elastic Compute Cloud)

- Go the Route tables and assign the Explicit subnet associations respective.
- Go to the public route table the use Edit routes.
- we are going to add ```0.0.0.0/0``` rule so we can give access to the public.
- Target select the Internet gateway (Attach that created Internet gateway).

## You are ready to go. create a EC2 instance. using what we created VPC

- use public subnet to create a EC2.
- to connect with local use ssh using connect option you will get a path like below,

```bash
    ssh -i "ec2_key_pair.pem" ec2-user@13.234.225.93
 ```

## Private subnet and route table will used for private internal EC2

### ref ./vpc-internal-ec2-nat

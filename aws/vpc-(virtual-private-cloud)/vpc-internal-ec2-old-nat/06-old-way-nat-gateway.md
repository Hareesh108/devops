
## You are ready to go. create a EC2 instance. using what we created VPC

- use public subnet to create a EC2.
- to connect with local use ssh using connect option you will get a path like below,
- Example:

```bash
    ssh -i "ec2_key_pair.pem" ec2-user@13.234.225.93
 ```

- Use private subnet to create a EC2.
- Example:

```bash
    ssh -i "ec2_key_pair.pem" ec2-user@13.234.225.93
 ```

- Go inside above public ec2 and add the .pem file and do try to ssh inside that private ec2.
- Later, if you try to access public api like ```ping google.com```
- It will not allow to access.
- To do this we need to create NAT  ```Network Address Translation``` gateway.
- lets create a NAT gateway.

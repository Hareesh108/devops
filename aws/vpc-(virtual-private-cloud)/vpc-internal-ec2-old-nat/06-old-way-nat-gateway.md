
## You are ready to go. create a EC2 instance. using what we created VPC

- Use public subnet to create a EC2.
- To connect with local use ssh using connect option you will get a path like below,
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
- ```scp -i "ec2_key_pair.pem" -r ./ec2_key_pair.pem ec2-user@52.66.103.135:/home/ec2-user/``` secure copy local to VM machine.
- Later, if you try to access public api like ```ping google.com```
- It will not allow to access.
- To do this we need to create NAT  ```Network Address Translation``` gateway.
- Lets create a NAT gateway.

### Start NAT gateway using AMI (Amazon Machine Image)

- Search for any nat provider
- It is assign the public subnet which you created inside VPC.
- Example: ```amzn-ami-vpc-nat-2018.03.0.20230607.0-x86_64-ebs```
- In Network setting added:
- ```HTTP, HTTPS and All ICMP - IPv4 with source: 0.0.0.0/16```
- Create a instance:
- Right click and select the Networking -> Change Source / destination check
- Then Source / destination checking (stop checkmark) and save.

### Start NAT gateway using AMI (Amazon Machine Image): EC2

- Search for any nat provider.
- It is assign the public subnet which you created inside VPC.
- In Network setting added:
- Deploy in the ```public-subnet-a```.
- ```HTTP, HTTPS and All ICMP - IPv4 with source: 0.0.0.0/16```
- Create a instance:
- Right click and select the Networking -> Change Source / destination check
- Then Source / destination checking (stop checkmark) and save.
- Lets re connect EC2.
- After this if you try to ping google. It still not able to connect.
- Lets give internet access to private subnet.

### Go to private Route table Route

- Select route then add route ```0.0.0.0/0```.
- target to created NAT (Network Address Translation) instance.
- Save changes.
- Now you should able to connect.

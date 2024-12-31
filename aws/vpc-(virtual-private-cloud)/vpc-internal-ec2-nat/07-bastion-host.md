## Lets create Bastion Host

- We already created a EC2 using public subnet so lets rename as Bastion host.
- From this will able to connect to the EC2 in private subnet.
- Create a EC2 using private subnet.
- Network setting select ```private-subnet-a```.
- ``private-demo`` group name.
- Lets try to connect through Bastion host.
- First secure copy into EC2 ```scp -i "ec2_key_pair.pem" -r ./ec2_key_pair.pem ec2-user@13.232.27.172:/home/ec2-user/```
- Do ssh inside Bastion Host ```ssh -i ec2_key_pair.pem ec2-user@10.0.27.137```
- Above use IP Address of that Instance.
- I am able to connect internally.
- But issue is the will not able access public IP from outside.
- Try ```ping google.com```.
- We need to create the NAT ```Network Address Translation```.

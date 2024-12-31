## Create a EC2 instance. using what we created VPC

- Click on ```Launch an instance```.
- Fill the info accordingly. 4
- Go to ```Network settings``` and select the VPC you created. and select the ```public-subnet-a```.
- Security group name ```public-a```
- description ```public-a created 2024-12-31T05:17:10.792Z```

## Lets start use to EC2

- To connect with local use ssh using connect option you will get a path like below,
- Example:

```bash
    ssh -i "ec2_key_pair.pem" ec2-user@13.234.225.93
 ```

- Ohh, you will not able to connect above instance.
- Now, we need internet gateway to connect.
- SO, lets create a Internet Gateway!

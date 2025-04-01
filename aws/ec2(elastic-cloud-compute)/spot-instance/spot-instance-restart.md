# AWS Spot Instance Restart Guide

## Understanding Spot Instance Termination and Restart

AWS Spot Instances run when capacity is available and your bid price exceeds the current spot price. However, they can be **interrupted** or **terminated** by AWS at any time when capacity is needed for On-Demand instances.

### When Does a Spot Instance Restart?

1. **Spot Instance Interruption Notice:** AWS provides a **2-minute warning** before terminating a spot instance.
2. **Persistent Spot Requests:** If your Spot Instance request is persistent, AWS will try to restart the instance when capacity is available.
3. **Spot Fleet Configuration:** If you're using a Spot Fleet with **maintain mode**, AWS will attempt to launch a new instance after termination.
4. **Spot Instance Auto-Recovery:** If you enable an EC2 Auto Scaling group with spot instances, the instance will automatically restart when capacity becomes available.

## How to Configure Automatic Restart of Spot Instances

### Option 1: Using a Persistent Spot Request

Create a **persistent** Spot Instance request to ensure it restarts after termination.

```sh
aws ec2 request-spot-instances \
    --instance-count 1 \
    --type "persistent" \
    --launch-specification file://spot-instance-config.json
```

### Option 2: Using an Auto Scaling Group

Create an Auto Scaling group with Spot Instances for automatic recovery.

```sh
aws autoscaling create-auto-scaling-group \
    --auto-scaling-group-name my-spot-group \
    --instance-id i-1234567890abcdef0 \
    --min-size 1 \
    --max-size 3 \
    --desired-capacity 1 \
    --spot-price "0.05"
```

### Option 3: Using Spot Fleet with "maintain" Mode

Spot Fleet will replace terminated instances automatically.

```sh
aws ec2 request-spot-fleet \
    --spot-fleet-request-config file://spot-fleet-config.json
```

Example `spot-fleet-config.json`:

```json
{
    "SpotFleetRequestConfig": {
        "TargetCapacity": 2,
        "IamFleetRole": "arn:aws:iam::123456789012:role/aws-ec2-spot-fleet-role",
        "LaunchSpecifications": [
            {
                "ImageId": "ami-12345678",
                "InstanceType": "c5.large"
            }
        ],
        "Type": "maintain"
    }
}
```

## How Long Does Restart Take?

- **If AWS terminates your instance**: It depends on availability and your request settings.
- **Persistent Spot Request**: Usually a few minutes if capacity is available.
- **Auto Scaling Group or Spot Fleet**: Instances restart within **seconds to minutes**, depending on how AWS provisions capacity.

## Checking Spot Instance Interruption Notices

You can check if AWS is planning to terminate your instance using the following command:

```sh
aws ec2 describe-spot-instance-requests
```

Or check metadata from inside the instance:

```sh
curl -s http://169.254.169.254/latest/meta-data/spot/termination-time
```

If the command returns a timestamp, your instance will be terminated soon.

## Summary

| Method | How It Works | Restart Time |
|--------|-------------|--------------|
| **Persistent Spot Request** | Requests the instance again when capacity is available | Minutes |
| **Spot Fleet (Maintain Mode)** | Replaces terminated instances automatically | Seconds - Minutes |
| **Auto Scaling Group** | Launches a new instance if terminated | Seconds - Minutes |

This guide ensures your Spot Instances can restart efficiently after termination. 🚀

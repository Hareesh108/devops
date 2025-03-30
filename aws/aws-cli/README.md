# AWS CLI Configuration Guide

## Set AWS CLI to the local

- Install AWS CLI

## Configure AWS CLI for Multiple Accounts

1. Navigate to AWS configuration folder:

   ```sh
   cd ~/.aws
   ```

2. Create or edit `config` and `credentials` files.

### `config` file

```ini
[default]
region = ap-south-1

[profile zero]
sso_session = eStatement-RD-Ext
sso_account_id = 05826447437348837137
sso_role_name = eStatement-RD-Ext-21
region = ap-southeast-1
output = json

[sso-session eStatement-RD-Ext]
sso_start_url = https://d-966dhjhjssa1e7f.awsapps.com/start/#
sso_region = ap-southeast-2
sso_registration_scopes = sso:account:access--

[profile one]
region = ap-south-1

[profile two]
region = ap-south-1

[profile three]
region = ap-south-1
```

### `credentials` file

```ini
[058264437137_eStatkislk]
aws_access_key_id=<KEY_ID>
aws_secret_access_key=<ACCESS_KEY>
aws_session_token=IQoJb3clclkclJpZ2lu'dlsal'X2VjEJL

[default]
aws_access_key_id = <KEY_ID>

[profile1]
aws_access_key_id = <KEY_ID>
aws_secret_access_key = <ACCESS_KEY>

[profile2]

[shubham]
aws_access_key_id = <KEY_ID>
aws_secret_access_key = <ACCESS_KEY>
```

## Switching Between AWS Profiles

To switch between multiple AWS accounts:

```sh
aws sso login --profile zero
aws sso login --profile one
```

For CLI operations using a specific profile:

```sh
aws s3 ls --profile zero
```

## Configuring AWS CLI for a Specific Profile

To configure AWS CLI for a specific profile, use:

```sh
aws configure --profile <PROFILE_NAME>
```

Example:

```sh
aws configure --profile harsh
```

You will be prompted to enter:

- AWS Access Key ID
- AWS Secret Access Key
- Default Region Name (e.g., `ap-south-1`)
- Default Output Format (`json`, `text`, or `table`)

After configuring, use the profile for commands:

```sh
aws s3 ls --profile harsh
aws ec2 describe-instances --profile harsh
```

If you want to use it for current session. you can set and use it.

```sh
export AWS_PROFILE=<profile  name>
```

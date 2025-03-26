# AWS Lambda Setup Guide

## 1. Pre-requisites

Before setting up AWS Lambda, ensure you have:

- An AWS account
- AWS CLI installed and configured (`aws configure`)
- IAM user/role with `AWSLambdaFullAccess` permissions
- AWS SAM CLI (optional for local development)

## 2. Create a Lambda Function

### Using AWS Management Console

1. Navigate to **AWS Lambda** in AWS Console.
2. Click **Create function**.
3. Select **Author from scratch**.
4. Provide a **Function name** (e.g., `my-lambda-function`).
5. Choose a **Runtime** (e.g., Python 3.9, Node.js 18, Java 17).
6. Select an **Execution Role** (Create a new role or use an existing one).
7. Click **Create function**.

### Using AWS CLI

```sh
aws lambda create-function \
  --function-name my-lambda-function \
  --runtime python3.9 \
  --role arn:aws:iam::123456789012:role/lambda-role \
  --handler lambda_function.lambda_handler \
  --zip-file fileb://function.zip
```

## 3. Deploy Lambda Code

1. Write a simple Python function (`lambda_function.py`):

```python
def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': 'Hello from AWS Lambda!'
    }
```

2. Package the function:

```sh
zip function.zip lambda_function.py
```

3. Update the Lambda function:

```sh
aws lambda update-function-code --function-name my-lambda-function --zip-file fileb://function.zip
```

## 4. Invoke Lambda Function

```sh
aws lambda invoke --function-name my-lambda-function response.json
```

## 5. Automating with Terraform (Optional)

Define Lambda in a Terraform file (`lambda.tf`):

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "my_lambda" {
  function_name    = "my-lambda-function"
  runtime         = "python3.9"
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  filename        = "function.zip"
}
```

Apply the configuration:

```sh
terraform init
terraform apply -auto-approve
```

## 6. Next Steps

- Integrate Lambda with **API Gateway** for REST APIs.
- Trigger Lambda using **S3, DynamoDB, SNS, or EventBridge**.
- Use **AWS SAM** or **Serverless Framework** for advanced deployments.

---
This guide covers setting up AWS Lambda, deploying code, invoking functions, and automating with Terraform.

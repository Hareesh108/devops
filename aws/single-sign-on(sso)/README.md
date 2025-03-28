# AWS Single Sign-On (SSO) Setup Guide

## 1. Pre-requisites

Before setting up AWS Single Sign-On (SSO), ensure you have:

- An AWS account with **Administrator Access**.
- AWS Organizations enabled (SSO requires Organizations).
- A directory service if integrating with external Identity Providers (e.g., Active Directory, Okta, Google Workspace).

## 2. Enable AWS Single Sign-On

### Using AWS Console

1. Navigate to **AWS Management Console**.
2. Go to **AWS SSO** service.
3. Click **Enable AWS SSO**.
4. AWS will automatically create a **default identity store**.
5. Click **View AWS SSO settings**.

## 3. Configure Identity Source

AWS SSO supports the following identity sources:

- **AWS SSO Directory** (default option)
- **Active Directory (AD)**
- **External Identity Provider (IdP)** (SAML 2.0 integration)

### Using AWS Console

1. Navigate to **AWS SSO settings**.
2. Under **Identity Source**, click **Change identity source**.
3. Select one of the following:
   - **AWS SSO Directory** (default, managed by AWS).
   - **Active Directory** (Connect to AWS Managed Microsoft AD or on-premises AD).
   - **External Identity Provider (SAML 2.0)** (Integrate with Okta, Google, Azure AD, etc.).
4. Follow the on-screen steps to configure and save changes.

## 4. Create and Manage Users

### Using AWS Console

1. Navigate to **AWS SSO Users**.
2. Click **Add user**.
3. Enter **Username, Email, First Name, Last Name**.
4. Set a **Temporary Password**.
5. Click **Create User**.

## 5. Create Permission Sets

Permission sets define IAM permissions for users.

### Using AWS Console

1. Go to **AWS SSO** > **Permission Sets**.
2. Click **Create Permission Set**.
3. Choose a method:
   - **AWS Managed Policies** (e.g., AdministratorAccess, ReadOnlyAccess).
   - **Custom Policies** (Define custom IAM policies).
4. Click **Create**.

## 6. Assign Users to AWS Accounts

### Using AWS Console

1. Navigate to **AWS SSO**.
2. Click **AWS Accounts**.
3. Select an AWS Account.
4. Click **Assign Users**.
5. Select **Users or Groups**.
6. Choose **Permission Set**.
7. Click **Assign**.

## 7. Configure External Identity Provider (Optional)

To integrate AWS SSO with an external IdP like **Okta, Azure AD, or Google**, use **SAML 2.0**.

### Steps

1. Go to **AWS SSO Settings** > **Identity Source**.
2. Select **External Identity Provider (SAML 2.0)**.
3. Download the AWS **Metadata file**.
4. In the external IdP (e.g., Okta, Azure AD), create an **AWS SAML App**.
5. Upload the AWS metadata file to the IdP.
6. Configure attribute mappings for user authentication.
7. Save and activate the configuration.

## 8. Enable Multi-Factor Authentication (MFA)

### Using AWS Console

1. Navigate to **AWS SSO Settings**.
2. Click **Multi-Factor Authentication (MFA)**.
3. Enable **MFA Required**.
4. Choose an authentication method:
   - **TOTP-based apps (Google Authenticator, Authy)**.
   - **WebAuthn (YubiKey, biometric authentication)**.
5. Click **Save**.

## 9. Test AWS SSO Login

1. Navigate to the AWS SSO **User Portal URL** (found in AWS SSO settings).
2. Log in with an assigned user.
3. Verify account access and permissions.
4. Confirm authentication through **MFA (if enabled)**.

## 10. Automating AWS SSO with Terraform (Optional)

Define AWS SSO settings in `aws_sso.tf`:

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_ssoadmin_permission_set" "admin_access" {
  instance_arn = aws_ssoadmin_instance.main.arn
  name         = "AdminAccess"
  description  = "Admin access to AWS accounts"
  managed_policies = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}
```

Apply the configuration:

```sh
terraform init
terraform apply -auto-approve
```

## 11. Next Steps

- **Integrate AWS SSO with AWS CLI** (`aws sso login`).
- **Configure session policies** for security best practices.
- **Enable logging and monitoring** using AWS CloudTrail.

---
This guide provides a step-by-step process for setting up AWS SSO, configuring identity sources, managing users, and integrating external IdPs.

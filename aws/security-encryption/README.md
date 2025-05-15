# AWS Security Services: KMS, SSM, and Secrets Manager Comparison

## AWS KMS (Key Management Service)

- Core encryption service for AWS
- Manages encryption keys
- Primarily focused on key creation and rotation
- Best for managing cryptographic keys and performing encryption operations

## AWS SSM (Systems Manager Parameter Store)

- Simple key-value storage
- Free tier available
- Basic encryption using KMS
- Best for configuration and secrets management at small scale
- Limited versioning capabilities

## AWS Secrets Manager

- Specialized service for secrets management
- Automatic rotation of secrets
- Native integration with AWS services
- Built-in support for database credentials
- More expensive than Parameter Store
- Best for managing sensitive credentials with automatic rotation

### When to Use Each

- **KMS**: Raw encryption operations and key management
- **SSM**: Simple configuration and small-scale secrets
- **Secrets Manager**: Critical secrets requiring automatic rotation

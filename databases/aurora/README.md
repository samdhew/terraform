# AWS Aurora Terraform Module

This Terraform module provisions an AWS Aurora database, supporting both Aurora provisioned and Aurora Serverless v2 configurations. The module creates essential resources, including IAM roles, KMS key, parameter group, subnet group, security group, SNS topic, Secrets Manager secret, Route 53 CNAME, Aurora event subscription, and CloudWatch alerts.

## Features

- Supports Aurora provisioned and Aurora Serverless v2 configurations.
- Creates IAM roles with the least privilege for Aurora.
- Manages a KMS key for encryption at rest.
- Configures Aurora parameters through a parameter group.
- Defines a subnet group for Aurora placement.
- Configures security groups for network access.
- Sets up an SNS topic for database events.
- Manages Secrets Manager secret for database credentials.
- Configures a Route 53 CNAME for easy access.
- Sets up an Aurora event subscription for capturing database events.
- Sets up CloudWatch alerts for key database metrics.

## Example
Check the `aurora_example` directory for a complete example on how to use this module.

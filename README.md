# OpenTofu AWS Static Hello World

This project deploys a minimal static `hello world` site on AWS using:

- S3 (private bucket for object storage)
- CloudFront (public HTTPS endpoint)
- Origin Access Control (CloudFront can read S3, public cannot)
- S3 + DynamoDB backend for Terraform/OpenTofu remote state and locking

The page content is managed directly in Terraform/OpenTofu (`aws_s3_object.index_html`).

## Prerequisites

- OpenTofu installed (`tofu` command)
- AWS credentials configured (environment variables, profile, or IAM role)
- Permission to create S3, CloudFront, IAM policy, and DynamoDB resources

## 1) Bootstrap remote state backend

Create the backend infra once (S3 bucket + DynamoDB lock table):

```bash
tofu -chdir=bootstrap init
tofu -chdir=bootstrap apply
```

Backend values are hardcoded in `main.tf` and use state key `env/prod/terraform.tfstate`.

## 2) Initialize this stack with remote state

```bash
tofu init -migrate-state
```

## 3) Deploy app infrastructure

```bash
tofu plan -var='site_name_slug=my-hello-site'
tofu apply -var='site_name_slug=my-hello-site'
```

After apply, get the site URL:

```bash
tofu output -raw site_url
```

CloudFront deployment can take several minutes.

## Required variables

- `site_name_slug` (no default, lowercase letters/numbers/hyphens)

## Optional variables

- `aws_region` (default: `us-east-1`)
- `bucket_name` (default: empty, auto-generated)

### Bootstrap-only variables

- `backend_bucket_name` (default: empty, auto-generated)
- `dynamodb_table_name` (default: `hello-world-static-site-tf-locks`)
- `state_key` (default: `env/prod/terraform.tfstate`)

Example:

```bash
tofu apply -var='site_name_slug=my-hello-site' -var='aws_region=us-east-1'
```

## Destroy

```bash
tofu destroy
```

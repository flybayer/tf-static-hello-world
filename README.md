# OpenTofu AWS Static Hello World

This project deploys a minimal static `hello world` site on AWS using:

- S3 (private bucket for object storage)
- CloudFront (public HTTPS endpoint)
- Origin Access Control (CloudFront can read S3, public cannot)

The page content is managed directly in Terraform/OpenTofu (`aws_s3_object.index_html`).

## Prerequisites

- OpenTofu installed (`tofu` command)
- AWS credentials configured (environment variables, profile, or IAM role)
- Permission to create S3, CloudFront, and IAM policy resources

## Deploy

```bash
tofu init
tofu plan
tofu apply
```

After apply, get the site URL:

```bash
tofu output -raw site_url
```

CloudFront deployment can take several minutes.

## Optional variables

- `aws_region` (default: `us-east-1`)
- `project_name` (default: `hello-world-static-site`)
- `bucket_name` (default: empty, auto-generated)

Example:

```bash
tofu apply -var='aws_region=us-east-1' -var='project_name=my-hello-site'
```

## Destroy

```bash
tofu destroy
```

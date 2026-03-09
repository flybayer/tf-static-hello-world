variable "aws_region" {
  description = "AWS region for the remote state backend resources."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project prefix used in generated backend resource names."
  type        = string
  default     = "hello-world-static-site"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "backend_bucket_name" {
  description = "Optional explicit S3 bucket name for remote state. Leave empty to auto-generate one."
  type        = string
  default     = ""

  validation {
    condition = (
      var.backend_bucket_name == "" ||
      can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.backend_bucket_name))
    )
    error_message = "backend_bucket_name must be empty or a valid S3 bucket name (3-63 chars, lowercase letters, numbers, dots, hyphens)."
  }
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name used for Terraform/OpenTofu state locking."
  type        = string
  default     = "hello-world-static-site-tf-locks"
}

variable "state_key" {
  description = "State object key path to use in the backend S3 bucket."
  type        = string
  default     = "env/prod/terraform.tfstate"
}

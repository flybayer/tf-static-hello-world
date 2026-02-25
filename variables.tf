variable "aws_region" {
  description = "AWS region for S3 and CloudFront-related resources."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project prefix used in generated resource names."
  type        = string
  default     = "hello-world-static-site"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "bucket_name" {
  description = "Optional explicit S3 bucket name. Leave empty to auto-generate one."
  type        = string
  default     = ""

  validation {
    condition = (
      var.bucket_name == "" ||
      can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    )
    error_message = "bucket_name must be empty or a valid S3 bucket name (3-63 chars, lowercase letters, numbers, dots, hyphens)."
  }
}

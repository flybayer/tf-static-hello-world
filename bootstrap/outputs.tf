output "backend_bucket_name" {
  description = "S3 bucket name for Terraform/OpenTofu remote state"
  value       = aws_s3_bucket.tf_state.bucket
}

output "backend_lock_table_name" {
  description = "DynamoDB table name for Terraform/OpenTofu state locking"
  value       = aws_dynamodb_table.tf_lock.name
}

output "backend_region" {
  description = "AWS region hosting backend resources"
  value       = var.aws_region
}

output "backend_state_key" {
  description = "State key path to use in backend configuration"
  value       = var.state_key
}

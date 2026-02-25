output "bucket_name" {
  description = "S3 bucket storing static site content"
  value       = aws_s3_bucket.site.bucket
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "site_url" {
  description = "URL for the static site"
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
}

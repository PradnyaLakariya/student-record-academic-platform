output "app_public_ip" {
  description = "Public IPv4 address of the application EC2 instance."
  value       = aws_instance.app.public_ip
}

output "app_url" {
  description = "Application URL via Nginx."
  value       = "http://${aws_instance.app.public_ip}"
}

output "api_url" {
  description = "Direct API URL for assignment testing."
  value       = "http://${aws_instance.app.public_ip}:8080"
}

output "s3_bucket_name" {
  description = "Private versioned S3 bucket created for the assignment."
  value       = aws_s3_bucket.backups.bucket
}

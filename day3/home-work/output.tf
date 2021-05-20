output "s3_bucket_id" {
  // this s3_bucket is the output from the "modlues/s3/output.tf" output resource id.
  value = module.s3.s3_bucket.id
}

output "s3_bucket_arn" {
  value = module.s3.s3_bucket.arn
}
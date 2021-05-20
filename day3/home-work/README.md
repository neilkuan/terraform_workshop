# terraform_workshop day3 lab (home work)

## Clone project 
```bash
$ git clone https://github.com/neilkuan/terraform_workshop.git
```

## install provider.
```bash
$ cd day3/home-work

$ terraform init
--- example output ---
Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.42.0...
- Installed hashicorp/aws v3.42.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

## To plan
```bash
$ terraform plan
--- example output ---
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.s3.aws_s3_bucket.home_work_bucket will be created
  + resource "aws_s3_bucket" "home_work_bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = "private"
      + arn                         = (known after apply)
      + bucket                      = (known after apply)
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags                        = {
          + "Environment" = "terraform-lab-dev"
          + "Name"        = "terraform-lab-home-work-bucket"
        }
      + tags_all                    = {
          + "Environment" = "terraform-lab-dev"
          + "Name"        = "terraform-lab-home-work-bucket"
        }
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + versioning {
          + enabled    = (known after apply)
          + mfa_delete = (known after apply)
        }
    }

# module.s3.random_id.bucket_name_suffix will be created
  + resource "random_id" "bucket_name_suffix" {
      + b64_std     = (known after apply)
      + b64_url     = (known after apply)
      + byte_length = 4
      + dec         = (known after apply)
      + hex         = (known after apply)
      + id          = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + s3_bucket_arn = (known after apply)
  + s3_bucket_id  = (known after apply)
```

## To deploy 
```bash
$ terraform apply 
--- example output ---
module.s3.random_id.bucket_name_suffix: Creating...
module.s3.random_id.bucket_name_suffix: Creation complete after 0s [id=U9YtqQ]
module.s3.aws_s3_bucket.home_work_bucket: Creating...
module.s3.aws_s3_bucket.home_work_bucket: Still creating... [10s elapsed]
module.s3.aws_s3_bucket.home_work_bucket: Still creating... [20s elapsed]
module.s3.aws_s3_bucket.home_work_bucket: Creation complete after 22s [id=terraform-lab-home-work-bucket-53d62da9]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

s3_bucket_arn = "arn:aws:s3:::terraform-lab-home-work-bucket-53d62da9"
s3_bucket_id = "terraform-lab-home-work-bucket-53d62da9"
```

## To destroy 
```bash
$ terraform destroy
--- example output ---
module.s3.random_id.bucket_name_suffix: Refreshing state... [id=U9YtqQ]
module.s3.aws_s3_bucket.home_work_bucket: Refreshing state... [id=terraform-lab-home-work-bucket-53d62da9]
module.s3.aws_s3_bucket.home_work_bucket: Destroying... [id=terraform-lab-home-work-bucket-53d62da9]
module.s3.aws_s3_bucket.home_work_bucket: Destruction complete after 1s
module.s3.random_id.bucket_name_suffix: Destroying... [id=U9YtqQ]
module.s3.random_id.bucket_name_suffix: Destruction complete after 0s

Destroy complete! Resources: 2 destroyed.
```
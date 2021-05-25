# terraform_workshop day4 lab1 use remote github repo modules.

## Clone project 
```bash
$ git clone https://github.com/neilkuan/terraform_workshop.git
```

## install provider.
today use remote github repo module. ex: https://github.com/cloudtp/hello-terraform-module
```bash
$ cd day4/lab1

$ terraform init
--- example output ---
Initializing modules...
Downloading github.com/cloudtp/hello-terraform-module for ec2_with_mandatory_tagging...
- ec2_with_mandatory_tagging in .terraform/modules/ec2_with_mandatory_tagging

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
> the variable will need to give when use this [module](https://github.com/cloudtp/hello-terraform-module).
> https://github.com/cloudtp/hello-terraform-module/blob/master/vars.tf
> `Name` , `user_id` , `EndDate`

```bash
$ terraform plan
--- example output ---
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.ec2_with_mandatory_tagging.aws_instance.example will be created
  + resource "aws_instance" "example" {
      + ami                                  = "ami-0ee02acd56a52998e"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      ...
      ...
      ...
      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

```

## To deploy 
```bash
$ terraform apply 
--- example output ---
module.ec2_with_mandatory_tagging.aws_instance.example: Creating...
module.ec2_with_mandatory_tagging.aws_instance.example: Still creating... [10s elapsed]
module.ec2_with_mandatory_tagging.aws_instance.example: Still creating... [20s elapsed]
module.ec2_with_mandatory_tagging.aws_instance.example: Still creating... [30s elapsed]
module.ec2_with_mandatory_tagging.aws_instance.example: Still creating... [40s elapsed]
module.ec2_with_mandatory_tagging.aws_instance.example: Creation complete after 47s [id=i-0255e09d49569dcd8]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## To destroy 
```bash
$ terraform destroy
--- example output ---
module.ec2_with_mandatory_tagging.aws_instance.example: Refreshing state... [id=i-0255e09d49569dcd8]
module.ec2_with_mandatory_tagging.aws_instance.example: Destroying... [id=i-0255e09d49569dcd8]
module.ec2_with_mandatory_tagging.aws_instance.example: Still destroying... [id=i-0255e09d49569dcd8, 10s elapsed]
module.ec2_with_mandatory_tagging.aws_instance.example: Still destroying... [id=i-0255e09d49569dcd8, 20s elapsed]
module.ec2_with_mandatory_tagging.aws_instance.example: Still destroying... [id=i-0255e09d49569dcd8, 30s elapsed]
module.ec2_with_mandatory_tagging.aws_instance.example: Destruction complete after 37s

Destroy complete! Resources: 1 destroyed.
```
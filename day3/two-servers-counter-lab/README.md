# terraform_workshop day3 lab count servers.

## Clone project 
```bash
$ git clone https://github.com/neilkuan/terraform_workshop.git
```

## install provider.
```bash
$ cd day3/two-servers-counter-lab

$ terraform init
--- example output ---
Initializing modules...
- vpc in modules/vpc

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.41.0...
- Installed hashicorp/aws v3.41.0 (signed by HashiCorp)

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
commands will detect it and remind you to do so if necessary
```

## To plan
```bash
$ terraform plan
--- example output ---
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.server1[0] will be created
  + resource "aws_instance" "server1" {
      + ami                                  = "ami-2757f631"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
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

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + instance_ip_addr = [
      + (known after apply),
      + (known after apply),
    ]
```

## To deploy 
```bash
$ terraform apply 
--- example output ---
aws_instance.server1[2]: Creating...
aws_instance.server1[1]: Creating...
aws_instance.server1[0]: Creating...
aws_instance.server1[1]: Still creating... [10s elapsed]
aws_instance.server1[0]: Still creating... [10s elapsed]
aws_instance.server1[2]: Still creating... [10s elapsed]
aws_instance.server1[2]: Still creating... [20s elapsed]
aws_instance.server1[0]: Still creating... [20s elapsed]
aws_instance.server1[1]: Still creating... [20s elapsed]
aws_instance.server1[0]: Still creating... [30s elapsed]
aws_instance.server1[1]: Still creating... [30s elapsed]
aws_instance.server1[2]: Still creating... [30s elapsed]
aws_instance.server1[0]: Still creating... [40s elapsed]
aws_instance.server1[2]: Still creating... [40s elapsed]
aws_instance.server1[1]: Still creating... [40s elapsed]
aws_instance.server1[1]: Creation complete after 45s [id=i-0eb7ac064b7b26f31]
aws_instance.server1[0]: Creation complete after 45s [id=i-0e967392644f6988c]
aws_instance.server1[2]: Creation complete after 45s [id=i-0dcdd8a18dc7152a9]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

instance_ip_addr = [
  "172.31.24.14",
  "172.31.18.93",
  "172.31.22.10",
]
```
![](./images/after_apply_console.png)


## To destroy 
```bash
$ terraform destroy
--- example output ---
aws_instance.server1[2]: Refreshing state... [id=i-0dcdd8a18dc7152a9]
aws_instance.server1[1]: Refreshing state... [id=i-0eb7ac064b7b26f31]
aws_instance.server1[0]: Refreshing state... [id=i-0e967392644f6988c]
aws_instance.server1[1]: Destroying... [id=i-0eb7ac064b7b26f31]
aws_instance.server1[0]: Destroying... [id=i-0e967392644f6988c]
aws_instance.server1[2]: Destroying... [id=i-0dcdd8a18dc7152a9]
aws_instance.server1[1]: Still destroying... [id=i-0eb7ac064b7b26f31, 10s elapsed]
aws_instance.server1[0]: Still destroying... [id=i-0e967392644f6988c, 10s elapsed]
aws_instance.server1[2]: Still destroying... [id=i-0dcdd8a18dc7152a9, 10s elapsed]
aws_instance.server1[2]: Still destroying... [id=i-0dcdd8a18dc7152a9, 20s elapsed]
aws_instance.server1[0]: Still destroying... [id=i-0e967392644f6988c, 20s elapsed]
aws_instance.server1[1]: Still destroying... [id=i-0eb7ac064b7b26f31, 20s elapsed]
aws_instance.server1[0]: Still destroying... [id=i-0e967392644f6988c, 30s elapsed]
aws_instance.server1[2]: Still destroying... [id=i-0dcdd8a18dc7152a9, 30s elapsed]
aws_instance.server1[1]: Still destroying... [id=i-0eb7ac064b7b26f31, 30s elapsed]
aws_instance.server1[0]: Destruction complete after 37s
aws_instance.server1[2]: Destruction complete after 37s
aws_instance.server1[1]: Destruction complete after 37s

Destroy complete! Resources: 3 destroyed.
```
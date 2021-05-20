# terraform_workshop day3 lab (Implicit depend on)

## Clone project 
```bash
$ git clone https://github.com/neilkuan/terraform_workshop.git
```

## install provider.
```bash
$ cd day3/two-servers-counter-implicit-depend-on-lab

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

  # aws_instance.server1 will be created
  + resource "aws_instance" "server1" {
      + ami                                  = "ami-2757f631"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      ...
      ...
      ...
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```

## To deploy 
> we can see the "aws_instance.server1: Creation complete after 35s [id=i-03edf5a62b8fbd24b] " and then create aws_instance.server2: Creation complete after 47s [id=i-0d5d6a17125cbd581]
```bash
$ terraform apply 
--- example output ---
aws_instance.server1: Creating...
aws_instance.server1: Still creating... [10s elapsed]
aws_instance.server1: Still creating... [20s elapsed]
aws_instance.server1: Still creating... [30s elapsed]
aws_instance.server1: Creation complete after 35s [id=i-03edf5a62b8fbd24b]
aws_instance.server2: Creating...
aws_instance.server2: Still creating... [10s elapsed]
aws_instance.server2: Still creating... [20s elapsed]
aws_instance.server2: Still creating... [30s elapsed]
aws_instance.server2: Still creating... [40s elapsed]
aws_instance.server2: Creation complete after 46s [id=i-0a99cbbcb6d420d9a]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

## To destroy 
> when destroy, we can see `server1` destroy after `server2` 
```bash
$ terraform destroy
--- example output ---
aws_instance.server1: Refreshing state... [id=i-03edf5a62b8fbd24b]
aws_instance.server2: Refreshing state... [id=i-0a99cbbcb6d420d9a]
aws_instance.server2: Destroying... [id=i-0a99cbbcb6d420d9a]
aws_instance.server2: Still destroying... [id=i-0a99cbbcb6d420d9a, 10s elapsed]
aws_instance.server2: Still destroying... [id=i-0a99cbbcb6d420d9a, 20s elapsed]
aws_instance.server2: Still destroying... [id=i-0a99cbbcb6d420d9a, 30s elapsed]
aws_instance.server2: Destruction complete after 37s
aws_instance.server1: Destroying... [id=i-03edf5a62b8fbd24b]
aws_instance.server1: Still destroying... [id=i-03edf5a62b8fbd24b, 10s elapsed]
aws_instance.server1: Still destroying... [id=i-03edf5a62b8fbd24b, 20s elapsed]
aws_instance.server1: Still destroying... [id=i-03edf5a62b8fbd24b, 30s elapsed]
aws_instance.server1: Destruction complete after 37s

Destroy complete! Resources: 2 destroyed.
```
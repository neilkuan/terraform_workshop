# terraform_workshop day3 lab count servers.

## Clone project 
```bash
$ git clone https://github.com/neilkuan/terraform_workshop.git
```

## install provider.
```bash
$ cd day3/exec-lab

$ terraform init
--- example output ---
Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/null...
- Installing hashicorp/null v3.1.0...
- Installed hashicorp/null v3.1.0 (signed by HashiCorp)

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

```

## To deploy 
```bash
$ terraform apply 
--- example output ---
null_resource.make-file: Creating...
null_resource.make-file: Provisioning with 'local-exec'...
null_resource.make-file (local-exec): Executing: ["/bin/sh" "-c" "echo '0' > test-file.txt"]
null_resource.make-file: Creation complete after 0s [id=6532704642136848855]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## To destroy 
```bash
$ terraform destroy
--- example output ---
null_resource.make-file: Refreshing state... [id=6532704642136848855]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # null_resource.make-file will be destroyed
  - resource "null_resource" "make-file" {
      - id = "6532704642136848855" -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

null_resource.make-file: Destroying... [id=6532704642136848855]
null_resource.make-file: Provisioning with 'local-exec'...
null_resource.make-file (local-exec): Executing: ["/bin/sh" "-c" "rm -f test-file.txt"]
null_resource.make-file: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
```
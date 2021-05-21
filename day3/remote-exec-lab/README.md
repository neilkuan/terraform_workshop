
## Test terraform function in terminal.
```bash
terraform console
--- example use join function ---
> join("-", ["sg", "hello"])
"sg-hello"
> exit
```

# terraform_workshop day3 lab remote exec lab

## Clone project 
```bash
$ git clone https://github.com/neilkuan/terraform_workshop.git
```

## install provider.
```bash
$ cd day3/remote-exec-lab

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

## *Create Gen your ssh key in your $HOME/.ssh*
> see `key_pair` docs: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
> see the note about ssh-keygen: https://gist.github.com/neilkuan/ede7d996b8949f0e555c195c7e863069
```bash
$ ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/example -P "" -C exampleuser@example.com
--- example output ---
Generating public/private rsa key pair.
Your identification has been saved in $HOME/.ssh/example.
Your public key has been saved in $HOME/.ssh/example.pub.
The key fingerprint is:
SHA256:xxxxxxxxx/xxxxxxxxxx/xxxxxxxxxxxxx exampleuser@example.com
The the randomart image of key is:
+---[RSA 4096]----+
|                 |
|                 |
.                 . 
.                 .
.                 .
|                 |
|                 |
+----[SHA256]-----+
-----------------------
```
```bash
$ ls $HOME/.ssh/example*
--- example output ---
$HOME/.ssh/example  $HOME/.ssh/example.pub
```
## To plan
```bash
$ terraform plan
--- example output ---
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:
  # aws_instance.remote-server will be created
  + resource "aws_instance" "remote-server" {
      + ami                                  = "ami-2757f631"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      ...
      ...
      ...
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "example_vpc"
        }
      + tags_all                         = {
          + "Name" = "example_vpc"
        }
    }

Plan: 9 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + private_ip                  = (known after apply)
  + public_ip_web_server        = (known after apply)
  + public_ip_web_server_remote = (known after apply)
```

## To deploy 
```bash
$ terraform apply 
--- example output ---
module.vpc.aws_vpc.example_vpc: Creating...
module.vpc.aws_vpc.example_vpc: Still creating... [10s elapsed]
module.vpc.aws_vpc.example_vpc: Still creating... [20s elapsed]
module.vpc.aws_vpc.example_vpc: Creation complete after 27s [id=vpc-02cf406707f4f8acd]
module.vpc.aws_internet_gateway.example_igw: Creating...
module.vpc.aws_subnet.example_subnet_1: Creating...
aws_security_group.web_server_sg: Creating...
module.vpc.aws_internet_gateway.example_igw: Creation complete after 7s [id=igw-0fdb74f4a425e4353]
module.vpc.aws_subnet.example_subnet_1: Still creating... [10s elapsed]
aws_security_group.web_server_sg: Still creating... [10s elapsed]
aws_security_group.web_server_sg: Creation complete after 11s [id=sg-05ddd6926b2e1b23d]
module.vpc.aws_subnet.example_subnet_1: Creation complete after 17s [id=subnet-03d206ed7ceff89aa]
module.vpc.aws_route_table_association.example_a_igw: Creating...
aws_instance.remote-server: Creating...
aws_instance.web_server: Creating...
module.vpc.aws_route_table_association.example_a_igw: Creation complete after 1s [id=rtbassoc-070ca87a00deb88e0]
module.vpc.aws_route.r_igw: Creating...
module.vpc.aws_route.r_igw: Creation complete after 4s [id=r-rtb-065fd32576b86b77b1080289494]
aws_instance.remote-server: Still creating... [10s elapsed]
aws_instance.web_server: Still creating... [10s elapsed]
aws_instance.web_server: Still creating... [20s elapsed]
aws_instance.remote-server: Still creating... [20s elapsed]
aws_instance.web_server: Still creating... [30s elapsed]
aws_instance.remote-server: Still creating... [30s elapsed]
aws_instance.web_server: Still creating... [40s elapsed]
aws_instance.remote-server: Still creating... [40s elapsed]
aws_instance.remote-server: Still creating... [50s elapsed]
aws_instance.web_server: Still creating... [50s elapsed]
aws_instance.web_server: Still creating... [1m0s elapsed]
aws_instance.remote-server: Still creating... [1m0s elapsed]
aws_instance.remote-server: Still creating... [1m10s elapsed]
aws_instance.web_server: Still creating... [1m10s elapsed]
aws_instance.web_server: Creation complete after 1m11s [id=i-08fd56f886984ec69]
aws_instance.remote-server: Still creating... [1m20s elapsed]
aws_instance.remote-server: Still creating... [1m30s elapsed]
aws_instance.remote-server: Provisioning with 'remote-exec'...
aws_instance.remote-server (remote-exec): Connecting to remote host via SSH...
aws_instance.remote-server (remote-exec):   Host: 18.204.231.77
aws_instance.remote-server (remote-exec):   User: ubuntu
aws_instance.remote-server (remote-exec):   Password: false
aws_instance.remote-server (remote-exec):   Private key: true
aws_instance.remote-server (remote-exec):   Certificate: false
aws_instance.remote-server (remote-exec):   SSH Agent: true
aws_instance.remote-server (remote-exec):   Checking Host Key: false
aws_instance.remote-server (remote-exec):   Target Platform: unix
aws_instance.remote-server (remote-exec): Connected!
aws_instance.remote-server (remote-exec): 0% [Working]
aws_instance.remote-server (remote-exec): Hit:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial InRelease
aws_instance.remote-server (remote-exec): 0% [Connecting to security.ubuntu.com]
aws_instance.remote-server (remote-exec): Get:2 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates InRelease [109 kB]
aws_instance.remote-server (remote-exec): 0% [Waiting for headers] [Connecting to
aws_instance.remote-server (remote-exec): Get:3 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-backports InRelease [107 kB]
...
...
...
aws_instance.remote-server (remote-exec): Setting up ssl-cert (1.0.37) ...
aws_instance.remote-server (remote-exec): Processing triggers for libc-bin (2.23-0ubuntu5) ...
aws_instance.remote-server (remote-exec): Processing triggers for systemd (229-4ubuntu16) ...
aws_instance.remote-server (remote-exec): Processing triggers for ureadahead (0.100.0-19) ...
aws_instance.remote-server (remote-exec): Processing triggers for ufw (0.35-0ubuntu2) ...
aws_instance.remote-server: Creation complete after 1m56s [id=i-0c67769589017f6c9]

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

private_ip = "10.0.0.146"
public_ip_web_server = "http://54.88.97.35"
public_ip_web_server_remote = "http://18.204.231.77"
```

## To destroy 
```bash
$ terraform destroy
--- example output ---
aws_key_pair.remote_server_key: Refreshing state... [id=remote_server]
module.vpc.aws_vpc.example_vpc: Refreshing state... [id=vpc-08d0352f0c1102abe]
module.vpc.aws_internet_gateway.example_igw: Refreshing state... [id=igw-0464f8973556202e7]
module.vpc.aws_subnet.example_subnet_1: Refreshing state... [id=subnet-06ebfc5c12f1864cd]
aws_security_group.web_server_sg: Refreshing state... [id=sg-0f863a7f74e2a5160]
module.vpc.aws_route_table_association.example_a_igw: Refreshing state... [id=rtbassoc-09ceca6b9f8f26886]
aws_instance.remote-server: Refreshing state... [id=i-05316cd53d7a6c0e0]
aws_instance.web_server: Refreshing state... [id=i-055e4cf9d49b4e345]
module.vpc.aws_route.r_igw: Refreshing state... [id=r-rtb-09f11db3c352299ea1080289494]
aws_instance.web_server: Destroying... [id=i-055e4cf9d49b4e345]
aws_instance.remote-server: Destroying... [id=i-05316cd53d7a6c0e0]
module.vpc.aws_route.r_igw: Destroying... [id=r-rtb-09f11db3c352299ea1080289494]
module.vpc.aws_route.r_igw: Destruction complete after 1s
module.vpc.aws_route_table_association.example_a_igw: Destroying... [id=rtbassoc-09ceca6b9f8f26886]
module.vpc.aws_internet_gateway.example_igw: Destroying... [id=igw-0464f8973556202e7]
module.vpc.aws_route_table_association.example_a_igw: Destruction complete after 2s
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 10s elapsed]
aws_instance.remote-server: Still destroying... [id=i-05316cd53d7a6c0e0, 10s elapsed]
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 10s elapsed]
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 20s elapsed]
aws_instance.remote-server: Still destroying... [id=i-05316cd53d7a6c0e0, 20s elapsed]
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 20s elapsed]
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 30s elapsed]
aws_instance.remote-server: Still destroying... [id=i-05316cd53d7a6c0e0, 30s elapsed]
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 30s elapsed]
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 40s elapsed]
aws_instance.remote-server: Still destroying... [id=i-05316cd53d7a6c0e0, 40s elapsed]
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 40s elapsed]
aws_instance.remote-server: Destruction complete after 49s
aws_key_pair.remote_server_key: Destroying... [id=remote_server]
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 50s elapsed]
aws_key_pair.remote_server_key: Destruction complete after 2s
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 50s elapsed]
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 1m0s elapsed]
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 1m0s elapsed]
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 1m10s elapsed]
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 1m10s elapsed]
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 1m20s elapsed]
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 1m20s elapsed]
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 1m30s elapsed]
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 1m30s elapsed]
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 1m40s elapsed]
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 1m40s elapsed]
aws_instance.web_server: Still destroying... [id=i-055e4cf9d49b4e345, 1m50s elapsed]
module.vpc.aws_internet_gateway.example_igw: Still destroying... [id=igw-0464f8973556202e7, 1m50s elapsed]
module.vpc.aws_internet_gateway.example_igw: Destruction complete after 1m52s
aws_instance.web_server: Destruction complete after 1m57s
module.vpc.aws_subnet.example_subnet_1: Destroying... [id=subnet-06ebfc5c12f1864cd]
aws_security_group.web_server_sg: Destroying... [id=sg-0f863a7f74e2a5160]
module.vpc.aws_subnet.example_subnet_1: Destruction complete after 3s
aws_security_group.web_server_sg: Destruction complete after 3s
module.vpc.aws_vpc.example_vpc: Destroying... [id=vpc-08d0352f0c1102abe]
module.vpc.aws_vpc.example_vpc: Destruction complete after 2s

Destroy complete! Resources: 9 destroyed.
```
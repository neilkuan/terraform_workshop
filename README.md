# terraform_workshop



### Get Amazon Linux Latest ami id from system manager parameter store.
```bash
$ aws ssm get-parameter --name /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2
{
    "Parameter": {
        "Name": "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2",
        "Type": "String",
        "Value": "ami-0ca38c7440de1749a",
        "Version": 46,
        "LastModifiedDate": "2021-05-04T09:49:48.400000+08:00",
        "ARN": "arn:aws:ssm:ap-northeast-1::parameter/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2",
        "DataType": "text"
    }
}
```
### Get Ubuntu 16.04 stable ami id from system manager parameter store.
```bash
$ aws ssm get-parameter --name /aws/service/canonical/ubuntu/server-minimal/16.04/stable/current/amd64/hvm/ebs-gp2/ami-id
{
    "Parameter": {
        "Name": "/aws/service/canonical/ubuntu/server-minimal/16.04/stable/current/amd64/hvm/ebs-gp2/ami-id",
        "Type": "String",
        "Value": "ami-0ed8d08d6a826a33e",
        "Version": 257,
        "LastModifiedDate": "2021-04-30T12:10:17.741000+08:00",
        "ARN": "arn:aws:ssm:ap-northeast-1::parameter/aws/service/canonical/ubuntu/server-minimal/16.04/stable/current/amd64/hvm/ebs-gp2/ami-id",
        "DataType": "aws:ec2:image"
    }
}
```
### Get Ubuntu 18.04 stable ami id from system manager parameter store.
```bash
$ aws ssm get-parameter --name /aws/service/canonical/ubuntu/server-minimal/18.04/stable/current/amd64/hvm/ebs-gp2/ami-id
{
    "Parameter": {
        "Name": "/aws/service/canonical/ubuntu/server-minimal/18.04/stable/current/amd64/hvm/ebs-gp2/ami-id",
        "Type": "String",
        "Value": "ami-0db5a383c6c0d8021",
        "Version": 274,
        "LastModifiedDate": "2021-05-13T18:05:30.745000+08:00",
        "ARN": "arn:aws:ssm:ap-northeast-1::parameter/aws/service/canonical/ubuntu/server-minimal/18.04/stable/current/amd64/hvm/ebs-gp2/ami-id",
        "DataType": "aws:ec2:image"
    }
}
```
### Get Ubuntu 20.04 stable ami id from system manager parameter store.
```bash
$ aws ssm get-parameter --name /aws/service/canonical/ubuntu/server-minimal/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id
{
    "Parameter": {
        "Name": "/aws/service/canonical/ubuntu/server-minimal/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id",
        "Type": "String",
        "Value": "ami-018c6d99103dd3888",
        "Version": 218,
        "LastModifiedDate": "2021-05-18T15:43:39.707000+08:00",
        "ARN": "arn:aws:ssm:ap-northeast-1::parameter/aws/service/canonical/ubuntu/server-minimal/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id",
        "DataType": "aws:ec2:image"
    }
}
```
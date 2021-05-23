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


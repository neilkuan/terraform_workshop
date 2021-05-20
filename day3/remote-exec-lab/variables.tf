variable "region" {
  type    = string
  default = "us-east-1"
}

variable "rules" {
  type = list(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 3689
      protocol    = "tcp"
      cidr_blocks = ["6.7.8.9/32"]
    }
  ]

}
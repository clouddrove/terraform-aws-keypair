## Managed By : CloudDrove
## Copyright @ CloudDrove. All Right Reserved.

#Module      : KEY PAIR
#Description : Provides an EC2 key pair resource.
#              A key pair is used to control login access to EC2 instances.
resource "aws_key_pair" "default" {
  count      = "${var.create_key_pair ? 1 : 0}"
  key_name   = "${var.key_name}"
  public_key = "${var.key}"
}

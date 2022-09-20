resource "aws_launch_configuration" "web" {
  name_prefix = "web"

  image_id = "ami-092b43193629811af" 
  instance_type = "t2.micro"
  key_name = "tests"

  security_groups = [ "${aws_security_group.demosg.id}" ]
  associate_public_ip_address = true
  user_data = "${file("data.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}

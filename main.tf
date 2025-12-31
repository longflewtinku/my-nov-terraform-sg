data "aws_vpc" "myalreadyvpc" {
    default = true
}
resource "aws_security_group" "myownsg" {
    name = "myopenallsg"
    description = "all network  sg"
    vpc_id = data.aws_vpc.myalreadyvpc.id
}
resource "aws_vpc_security_group_ingress_rule" "myingressrules" {
    security_group_id = aws_security_group.myownsg.id
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
  
}
resource "aws_key_pair" "myownkey" {
   public_key = file("~/id_rsa.pub")
   key_name = "mysshownkey"
  
}
data "aws_ami" "myapsouthami" {
    filter {
      name = "name"
      values = [ "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20251212" ]
    }
    owners = [ "099720109477" ]
}
resource "aws_instance" "myec2" {
    ami = data.aws_ami.myapsouthami.id
    instance_type = "t3.micro"
    key_name =  aws_key_pair.myownkey.key_name
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.myownsg.id]
    tags = {
      Name = "myterraformec2"
    }

}
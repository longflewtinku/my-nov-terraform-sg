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
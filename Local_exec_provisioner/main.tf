resource "aws_instance" "example" {
  ami           = "ami-01376101673c89611"
  instance_type = "t2.nano"

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
  
  tags = {
    Name = "final-test"
  }
}

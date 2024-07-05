provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("${path.module}/id_rsa.pub")

}


resource "aws_instance" "example" {
  ami           = "ami-01376101673c89611"
  instance_type = "t2.nano"

  vpc_security_group_ids = ["sg-08902816d2b63f5a6"]
  key_name               = aws_key_pair.deployer.key_name

  provisioner "remote-exec" {
    inline = [
      "sudo yum update",
      "sudo yum install -y httpd"
    ]
  

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/id_rsa")
      host        = aws_instance.example.public_ip
    }
  }

  tags = {
    Name = "final-test"
  }
}

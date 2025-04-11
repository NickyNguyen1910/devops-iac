resource "aws_key_pair" "deu1-testkey-001" {
key_name = "deu1-testkey-001"
public_key = "${file("${var.aws_deu1_testkey_001_file}.pub")}"
}
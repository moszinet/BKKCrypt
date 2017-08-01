# Usage: terraform apply -var password=your_password

variable "password" {}

output "encrypt" {
  value = "${var.password}"
}

variable "aws_region" {
  description = "AWS region for this assignment."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Short prefix used to name resources."
  type        = string
  default     = "student-record-platform"
}

variable "instance_type" {
  description = "EC2 instance type. Confirm current pricing and account eligibility."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair in the selected AWS region."
  type        = string
}

variable "ssh_cidr" {
  description = "Your public IPv4 address in CIDR format, e.g. 203.0.113.10/32."
  type        = string

  validation {
    condition     = can(cidrhost(var.ssh_cidr, 0))
    error_message = "ssh_cidr must be a valid CIDR range."
  }
}

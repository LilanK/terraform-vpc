variable "cidr" {
  type        = string
  default     = "10.0.0.0/16"
}
variable "instance_tenancy" {
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  default     = true
}

variable "enable_classiclink" {
  type        = bool
  default     = false
}

variable "tags" {
  type        = string
  default     = "test_vpc"
}

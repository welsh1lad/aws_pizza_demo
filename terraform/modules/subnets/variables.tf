variable "vpc_id" {
  type = string
}

variable "subnets" {
  description = "A map of subnet configurations"
  type = map(object({
    cidr_block    = string
    az_zone       = string
    public_enable = bool
    name          = string
  }))
}

variable "platform" {
  type = string
}

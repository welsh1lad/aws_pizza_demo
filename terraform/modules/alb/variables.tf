variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}
variable "subnet_ids" {
  description = "A list of subnet IDs to attach the ALB to"
  type        = list(string)
}
variable "security_group_ids" {
  description = "A list of security group IDs to associate with the ALB"
  type        = list(string)
}
variable "tags" {
  description = "A map of tags to assign to the ALB"
  type        = map(string)
  default     = {}
}

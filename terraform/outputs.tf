output "app_vpc_id" {
  description = "The ID of the App VPC"
  value       = module.app_vpc.vpc_id
}

output "service_vpc_id" {
  description = "The ID of the Services VPC"
  value       = module.service_vpc.vpc_id
}
output "name" {
  description = "The name of the Internet Gateway"
  value       = aws_internet_gateway.igw.tags["Name"]
}
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

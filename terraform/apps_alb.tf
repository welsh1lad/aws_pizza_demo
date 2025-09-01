module "apps_alb" {
  source = "./modules/alb"

  alb_name         = "app-alb"
  security_group_ids = [aws_security_group.internal.id]
  subnet_ids       = module.app_subnet.subnet_ids
}
###
# environment composition
###

module "key_vault" {
  source      = "./modules/key_vault"
  environment = var.environment
  region      = var.region
  tags        = var.tags
}

module "backend" {
  source                       = "./modules/backend"
  environment                  = var.environment
  region                       = var.region
  tags                         = var.tags
  administrator_login          = var.administrator_login
  administrator_login_password = module.key_vault.sql_password
}

module "iot" {
  source      = "./modules/iot"
  environment = var.environment
  region      = var.region
  tags        = var.tags
}

module "kubernetes" {
  source           = "./modules/kubernetes"
  environment      = var.environment
  region           = var.region
  tags             = var.tags
  address_space    = var.address_space
  address_prefixes = var.address_prefixes
}
module "instance_provisioning" {
  source      = "../module"
  sgname      = var.sgname
  cidr        = var.cidr
  mytag       = var.mytag
  amiid       = var.amiid
  machinetype = var.machinetype
  keyname     = var.keyname
}
module "instance_provisioning" {
  source           = "../module"
  sgname           = var.sgname
  cidr             = var.cidr
  mytag            = var.mytag
  amiid            = var.amiid
  machinetype      = var.machinetype
  keyname          = var.keyname
  vpcname          = var.vpcname
  IGname           = var.IGname
  rtname           = var.rtname
  subname          = var.subname
  availablity-zone = var.availablity-zone
}
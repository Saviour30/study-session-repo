module "vpc-vida" {
  source = "../VPC-child"
    
  vpc_cidr = "50.0.0.0/16"
  pub_cidr = "50.0.1.0/24"
  prv_cidr = "50.0.2.0/24"
  tag = "vida"

   enable_nat_gateway = true
    enable_internet_gateway = true

  
}



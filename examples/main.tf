terraform {
  required_providers {
    hashicups = {
      version = "0.2"
      source  = "hashicorp.com/edu/hashicups"
    }
  }
}

provider "hashicups" {}

#module "psl" {
#  source = "./coffee"

#  coffee_name = "Packer Spiced Latte"
#}

#output "psl" {
#  value = module.psl.coffee
#}

variable "coffee_name" {
  type    = string
  default = "Vagrante espresso"
}

data "hashicups_coffees" "all" {}

# Returns all coffees
output "all_coffees" {
  value = data.hashicups_coffees.all.coffees
}

# Only returns packer spiced latte
output "coffee" {
  value = {
    for coffee in data.hashicups_coffees.all.coffees :
    coffee.id => coffee
    if coffee.name == var.coffee_name
  }
}

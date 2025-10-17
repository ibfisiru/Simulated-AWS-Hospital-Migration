variable "vpc_name" {
  description = "The Name Of The VPC" # This will be defined within the 'tags' section of VPC resource
  type        = string

}

variable "cidr" { # This value is set at run time
  description = "The CIDR for this VPC"
  type        = string
}

#variable "vpc_region" { # This value is set at run time
 # description = "Region the VPC will be deployed in"
  #type        = string
#}

variable "dns" {
  description = "Boolean to enable or disable DNS in the VPC"
  type        = string
  default     = true
}

variable "dns_hostname" {
  description = "Boolean to enable or disable DNS hostnames in the VPC"
  type        = string
  default     = true
}

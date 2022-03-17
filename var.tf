### Server
variable "image_name" {
    type    =   string
    default =   "CentOS 7.8 (64-bit)"
}

variable "public_vm_cpu" {
    type    =   string
    default =   "2"
}
variable "public_vm_memory" {
    type    =   string
    default =   "8GB"
}

variable "public_product_type" {
    type    =   string
    default =   "STAND"
}

variable "private_product_type" {
    type    =   string
    default =   "STAND"
}


variable "public_vm_count" {
    type    =   number
    default =   0
}

variable "public_vm_subnets" {
    type    =   map
}

variable "public_vm_name" {
    type    =   string
    default =   "tf-server"
}

variable "private_vm_cpu" {
    type    =   string
    default =   "2"
}
variable "private_vm_memory" {
    type    =   string
    default =   "8GB"
}

variable "private_vm_count" {
    type    =   number
    default =   0
}

variable "private_vm_subnets" {
    type    =   map
}

variable "private_vm_name" {
    type    =   string
    default =   "tf-server"
}

variable "is_create_loginkey" {
    type    =   bool
    default =   true
}

variable "loginkey_name" {
    type    =   string
    default =   "loginkey_name"
}

variable "is_assign_public_ip" {
    type    =   bool
    default =   true
}

variable "is_set_password" {
    type    =   bool
    default =   true
}

variable "init_password" {
    type    =   string
    default =   "P@ssw0rd"
}

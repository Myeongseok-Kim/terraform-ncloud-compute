# Usage
```
module "compute" {
	source = "Myeongseok-Kim/vpc/ncloud"

// Server(Common)

    create_loginkey      =   true
    loginkey_name        =   "tf-key"
    image_name           =   "CentOS 7.8 (64-bit)"
    set_password         =   false
    init_password        =   "P@ssw0rd"


// Server(Public)

    assign_public_ip     =   true
    public_vm_name       =   "tf-public-server"
    public_vm_cpu        =   "2"
    public_vm_memory     =   "4GB"
    public_product_type  =   "HICPU" # HICPU | STAND | HIMEM
    public_vm_subnets    =   ["38124", "38123"] # use vpc module like [ for v in module.vpc.public_subnet : v.id ]
    public_vm_count      =   1


// Server(private)

    private_vm_name      =   "tf-private-server"
    private_vm_cpu       =   "2"
    private_vm_memory    =   "4GB"
    private_product_type =   "HICPU" # HICPU | STAND | HIMEM
    private_vm_subnets   =   ["38122", "38125"] # use vpc module like [ for v in module.vpc.public_subnet : v.id ]
    private_vm_count     =   1
}
```

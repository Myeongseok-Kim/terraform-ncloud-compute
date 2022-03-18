### Server
data "ncloud_server_image" "server_image" {
  filter {
    name = "product_name"
    values = [var.image_name]
  }
}

data "ncloud_server_product" "public_product" {
  server_image_product_code = data.ncloud_server_image.server_image.id

  filter {
    name   = "product_code"
    values = ["SSD"]
    regex  = true
  }
  filter {
    name   = "cpu_count"
    values = [var.public_vm_cpu]
  }
  filter {
    name   = "memory_size"
    values = [var.public_vm_memory]
  }
    filter {
    name   = "product_type"
    values = [var.public_product_type]
  }
}

data "ncloud_server_product" "private_product" {
  server_image_product_code = data.ncloud_server_image.server_image.id

  filter {
    name   = "product_code"
    values = ["SSD"]
    regex  = true
  }
  filter {
    name   = "cpu_count"
    values = [var.private_vm_cpu]
  }
  filter {
    name   = "memory_size"
    values = [var.private_vm_memory]
  }
      filter {
    name   = "product_type"
    values = [var.private_product_type]
  }
}

resource "ncloud_server" "public_server" {
    count                     = var.public_vm_count
    subnet_no                 = length(var.public_vm_subnets) == 1 ? var.public_vm_subnets[0] : var.public_vm_subnets["${count.index % 2}"]
    name                      = "${var.public_vm_name}-${count.index + 1}"
    server_image_product_code = data.ncloud_server_image.server_image.id
    server_product_code       = data.ncloud_server_product.public_product.id
    login_key_name            = var.loginkey_name
    init_script_no            = var.set_password ? ncloud_init_script.init.0.id : ""

    depends_on                = [ncloud_login_key.loginkey,ncloud_init_script.init]
}

resource "ncloud_server" "private_server" {
    count                     = var.private_vm_count
    subnet_no                 = length(var.private_vm_subnets) == 1 ? var.private_vm_subnets[0] : var.private_vm_subnets["${count.index % 2}"]
    name                      = "${var.private_vm_name}-${count.index + 1}"
    server_image_product_code = data.ncloud_server_image.server_image.id
    server_product_code       = data.ncloud_server_product.private_product.id
    login_key_name            = var.loginkey_name
    init_script_no            = var.set_password ? ncloud_init_script.init.0.id : ""

    depends_on                = [ncloud_login_key.loginkey,ncloud_init_script.init]
}

resource "ncloud_public_ip" "public_ip" {
    for_each                  = { for k, v in ncloud_server.public_server : k => v.id if var.assign_public_ip }
    server_instance_no        = each.value
}

resource "ncloud_login_key" "loginkey" {
    count                     = var.create_loginkey ? 1 : 0
    key_name                  = var.loginkey_name

    provisioner "local-exec" {
      command = <<-EOT
      echo "${nonsensitive(self.private_key)}" > ${self.key_name}.pem 
      EOT
      interpreter = ["bash","-c"]
    }
}

resource "ncloud_init_script" "init" {
    count                     = var.set_password ? 1 : 0
    name                      = "set-linux-password"
    content                   = "#!/usr/bin/bash \necho 'root:${var.init_password}' | chpasswd"
}
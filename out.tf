output "login_key_name"{
    value = { for k, v in ncloud_login_key.loginkey : k => v.key_name }
}

output "login_key"{
    value = { for k, v in ncloud_login_key.loginkey : k => v.private_key if var.create_loginkey }
}

output "public_ip"{
    value = { for k, v in ncloud_public_ip.public_ip : k => v.public_ip if var.assign_public_ip }
}
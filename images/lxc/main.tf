
terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.6"
    }
  }
}

locals {
  proxmox_api_url = "https://${var.proxmox_ip}:8006/api2/json"
}

provider "proxmox" {
  pm_api_url      = local.proxmox_api_url
  pm_tls_insecure = true

  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
}

module "base_lxc" {
  source = "../../terraform/modules/lxc"

  target_node  = var.target_node
  vm_id        = var.vm_id
  hostname     = "base-lxc"
  lxc_template = var.base_template
  unprivileged = true
  onboot       = true
  start        = true

  cores  = 1
  memory = 4096
  swap   = 2048

  size                 = var.size
  proxmox_storage_pool = var.proxmox_storage_pool

  bridge         = "vmbr1"
  ip_address     = var.ip_address
  gateway        = var.gateway
  ssh_public_key = tls_private_key.temp_private_key.public_key_openssh
}

resource "tls_private_key" "temp_private_key" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  content         = tls_private_key.temp_private_key.private_key_pem
  filename        = "../playbooks/private_key.pem"
  file_permission = "0600"

  depends_on = [tls_private_key.temp_private_key]
}

resource "null_resource" "provisioning" {

  provisioner "local-exec" {
    command = <<EOT
		echo LXC up!
		ANSIBLE_FORCE_COLOR=1 ansible-playbook ../playbooks/main.yml \
			-i ../playbooks/inventory/hosts.yml \
			--private-key ../playbooks/private_key.pem \
			--ssh-extra-args='-o StrictHostKeyChecking=no'
			-K \
			-e 'template_vmid=${var.vm_id}' \
			-e 'template_name=${var.template_name}'
	EOT
  }

  depends_on = [module.base_lxc, tls_private_key.temp_private_key]
}
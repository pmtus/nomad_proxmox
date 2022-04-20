
variable "proxmox_ip" {
  type        = string
  description = "IP of Proxmox server (mandatory)"
}

variable "proxmox_user" {
  type    = string
  default = "root@pam"
}

variable "proxmox_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "proxmox_api_token_id" {
  type      = string
  default   = ""
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  default   = ""
  sensitive = true
}

variable "target_node" {
  type    = string
  default = "pve"
}

variable "vmid" {
  type        = number
  description = "VM ID (mandatory)"
}

variable "proxmox_storage_pool" {
  type    = string
  default = "volumes"
}

variable "ssh_public_key" {
  type        = string
  description = "Public SSH key to root"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment (mandatory)"
}

variable "lxc_template_name" {
  type        = string
  description = "LXC template (mandatory)"
}

variable "mounts" {
  type        = list(any)
  description = "LXC mount points (optional)"
  default     = []
}

variable "ip_block" {
  type        = string
  description = "IP address block (mandatory)"
}

proxmox_ip         = "https://100.112.144.51:8006"
proxmox_api_token  = "root@pam!provisioning=390a1be3-fc5f-4c19-99db-5b03f3c74f5e"
control_ip_address = "145.224.115.122/24"
disk_datastore     = "zfs_nomad"
ip_gateway         = "10.10.20.1"
onboot             = false
servers = [
  {
    name       = "nomad-server"
    id         = 5110
    cores      = 2
    sockets    = 2
    memory     = 4096
    disk_size  = 10
    ip_address = "10.10.20.110/24"
  }
]
clients = [
  {
    name       = "nomad-client"
    id         = 5111
    cores      = 2
    sockets    = 2
    memory     = 10240
    disk_size  = 15
    ip_address = "10.10.20.111/24"
  }
]
ssh_public_key_file = "/Users/cmdel/.ssh/id_ed25519.pub"
ssh_user            = "debian"
started             = true
tags = [
  "prod"
]
target_node = "hznrde-hyperv-nomad"
template_id = "5000"

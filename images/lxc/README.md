# LXC Base Image Pipeline
## Overview
For LXCs, Terraform and Ansible are used to build templates.

1. Terraform provisions a temporary container from a known base image as a starting point
2. Ansible executes the changes in the container
3. Ansible stops the container and creates a template. This is done in the
   Proxmox host.
4. Terraform destroys the temporary container

## Usage
Ensure all variables are correct in `terraform.tfvars` and
`../ansible/vars.yml`. Then, run the following:

```bash
$ cd lxc/terraform
$ terraform init
$ terraform apply
```

Wait for templating to complete.

Finally, run `terraform destroy`. Refer to `setup` for a complete overview.

### Notes
When destroying and recreating a new LXC with the same IP, ensure that the ARP
table is cleared. Otherwise, the recreated host will not be reachable.

If `local-exec` provisioner fails to get successful SSH connection with the temp
LXC, it could be due to the following issues:

- `private_key.pem` is not passed correctly.
- `SSH host checking is still on`

Ensure the Ansible playbook dependencies are installed and updated with

```
$ ansible-galaxy install -f -r requirements.yml
```

## TODO
- For easier configuration, conslidate all key variables to one input file. Refer
to `terraform.tfvars` and `vars.yml` for all variables.
- Ansible inventory variables are not read. Add `working_dir` arg to `local-exec`
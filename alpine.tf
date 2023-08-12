terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.29.0"
    }
  }
}


provider "proxmox" {
  endpoint = "https://192.168.2.99:8006/"
  username = "root@pam"
  password = "soeid1"
  insecure = true
}

resource "proxmox_virtual_environment_vm" "alpine_vm" {
  count = 2
  name        = "test-alpine-vm-${count.index + 1}"
  description = "Managed by Terraform"
  tags        = ["terraform", "alpine"]
  
  node_name = "homelab"
  vm_id     = "432${count.index + 1}"

  agent {
    enabled = true
    timeout = "3m"
  }

  startup {
    order      = "3"
    up_delay   = "20"
    down_delay = "20"
  }

  network_device {
    bridge = "vmbr0"
  }

  clone {
    datastore_id = "pve-ssd"
    vm_id = 9988
  }
  
  operating_system {
    type = "l26"
  }

  serial_device {}

  initialization {
    datastore_id = "pve-ssd"
    ip_config {
      ipv4 {
        address = "192.168.2.214+${count.index}/24"
        gateway = "192.168.2.1"
      }
    }

}
}
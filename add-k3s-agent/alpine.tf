terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.29.0"
    }
  }
}


provider "proxmox" {
  endpoint = "https://192.168.2.254:8006/"
  username = "root@pam"
  password = "soeid1"
  insecure = true
}

variable "ip_list" {
  type = list(string)
  description = "Proxmox VM IP"
  default     = ["192.168.2.214/24", "192.168.2.215/24"]
}
resource "proxmox_virtual_environment_vm" "alpine_vm" {
  count = 2
  name        = "k3s-agent-${count.index + 4}"
  description = "Managed by Terraform"
  tags        = ["terraform", "alpine"]
  
  node_name = "tower"
  vm_id     = "432${count.index + 4}"

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
    datastore_id = "local-zfs"
    vm_id = 8888
  }
  
  operating_system {
    type = "l26"
  }

  serial_device {}

  initialization {
    datastore_id = "local-zfs"
    ip_config {
      ipv4 {
        address = element(var.ip_list, count.index)
        gateway = "192.168.2.1"
      }
    }

    user_account {
      keys     = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6jQt2h2sOr5Q2v+2P4+4Fmf3IeILavNT3ihltZWW+XD+IeIpX6MaUe7EzzqpvAaLhVU+z+rRZO+EteoOGWTrAmcF+RKnkJAWeNnEeDitrshepffkB7Bw20XKiQi7B7UeXJipwhsJnQAZjoITx7VtylS+j/ruYJSRaq7gOxUPMlvJRc1W4kPmQ3D/EyvSrlkglngs2aP0D/Wl+sQW2S9XxucjQPloJugBQkjdQrDW67SukpOjWN+04iXlYsDvN/XFwOabqc7ZeuaD//TUkd/G6l9n/9yjtnLO8Z883BT6NNXc35r4fybzNsT1rQ4q9Xg+wahtHzH3PtZUGBzLEadN/hwNKkblWdaCdhx4fxqD8HAy24xgUuCFpvz2QBkHqFBTB/NU3sEsnrUED2EE3QrVXXxb6MUXzp2/+M6JhgkWfni6Ua+o7L2EMQ4MSGcSWbTnijiEtjRPbQrgRnpjq/rny8rzhEpt9OMLRnI+H9E00S+NO18vcP2fcj7QF+RKYdnE= ap@DESKTOP-NIL7Q34","ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkRIQkJQz86g4y3K8VpvwwJgPoq39SvPraXoVclfWHfw52SeMaSamaryTALzrQ5szLl/Q/jRbVTjj2pGH3zBn2T1KVZyVVl3+hI6DytP6i0fv51/R8IOQ0bl3yvlBkG/FZPPkE0xtAR9ymuzbqzv2yICnl6PVA6JnGV80+Zde+b15nPUh1sGW5Dq/lsjxXBNaheGF40Ba/AF1UGDOAt4i99+riEkNPt/SMCSv9o4MIjpjip2Y2/JMhOw02bSzIg8ddXZZ37VAaE0oWSn/c2jxUW9VZddFlIn8PagKXafmfNCb4adBUeRk2rHI+KcE9Vnmxu9YyB11kShA+ChCzVS99 ap@docker","ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxlKV0wXixpQOzq+v3nJp4C43gAX26mpWa90MEn6Ez36LUfMaJYQ0V7jst3oUzIWMCbOi7C8x21LD+CZNoVy3/yI4hUYhki53aym6QNizpCgDygZ0z/hXzQX//hUw/Pro1ePUr7dsgyoCcV7ccb0EMi7L/WQqfEBySkQmZncLnw7quNbfLy+xZH6unOiCujQ+KAKmyBpQRVS5xIoUV5mleQsYCmHcvdjohl9mUeVeThKAukAExf0i05Nq9ZhR8U20ItXg2zIo26nlyidqzQghtvbOO5uSwCKKW4RXdao2RyJLyvuU+SIy1dsrmaYvDg0Vk7A6fMrREPxuD6DSbr/mB/OHDncchWcW00nJyZv1xs4SSXtDzv3I7FUhzhrXu8UhEcytyetV8ITml2khNoj3c+jLg/1sjsjdACaM9MiBQ3Jh44f3k/VOCXYIXKhLjn+DrU3CJvE6d6s6BzT/z/ThNt6YUUl/gl5tJq3KGmhVIhtOzCo0vU66s2NDFqAHRJXk= abc@code-server-6944f7b74c-kdzhl"]
      password = "soeid1"
      username = "alpine"
    }
}
}
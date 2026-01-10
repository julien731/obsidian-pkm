---
type: resource
created: 2026-01-10
status: active
tags:
  - proxmox
  - alpine
related:
  - "[[Setup a home lab]]"
migrated_from: notion
migrated_at: 2026-01-10
---

# How to create your own cloud-init alpine image for Proxmox


Use this post for the initial setup:

[How to create your own cloud-init alpine image for Proxmox](https://twdev.blog/2023/11/alpine_cloudinit/)

Use this post for the sudo and VM config:

[GitHub - red-lichtie/alpine-cloud-init: How to build a minimal cloud-init image for Proxmox](https://github.com/red-lichtie/alpine-cloud-init?tab=readme-ov-file)

---

1. Login with `root` (no password)
2. Run `setup-alpine`
    1. Don’t setup a new user
    2. Setup `openssh`
    3. Allow root login
    4. Use `lvmsys` for the disk type
    5. Reboot. You can now ssh into the VM using the `root` account
3. SSH into VM
    1. `apk add nano`
    2. `nano /etc/apk/repositories` and check that everything is enabled
    3. Install the following apps
        
        ```bash
        apk add \
            util-linux \
            e2fsprogs-extra \
            qemu-guest-agent \
            chrony \
            doas \
            sudo
        ```
        
    4. Setup qemu
        
        ```bash
        rc-update add qemu-guest-agent
        ```
        
    5. Setup remaining packages
        
        ```bash
        apk add \
            py3-netifaces \
            cloud-init
        ```
        
    6. Setup wheel
        
        ```bash
        echo '%wheel ALL=(ALL) NOPASSWD: ALL' > "/etc/sudoers.d/wheel"
        echo 'permit nopass :wheel' > "/etc/doas.d/wheel.conf"
        ```
        
    7. Disable `root` login
        
        ```bash
        nano /etc/ssh/sshd_config
        # Remove
        PermitRootLogin yes
        ```
        
    8. Explicitly lock the root account
        
        ```bash
        # explicitly lock the root account
        /bin/sh -c "/bin/echo 'root:*' | /usr/sbin/chpasswd -e"
        /usr/bin/passwd -l root
        ```
        
    9. Update services
        
        ```bash
        # Update services
        rc-update add chronyd default
        ```
        
    10. Setup cloud-init
        
        ```bash
        # Setup cloud-init defaults
        setup-cloud-init
        
        # Set Proxmox options as Datasources
        echo 'datasource_list: [ NoCloud, ConfigDrive ]' > "/etc/cloud/cloud.cfg.d/99_pve.cfg"
        
        # Shut down the VM and do **NOT** restart it
        poweroff
        ```

`echo '<password>' | mkpasswd -m sha-512 -s`



```
mkdir -p /var/lib/vz/snippets

cat > EOF.default << /var/lib/vz/snippets/927.yaml
  

#cloud-config
chpasswd:
  expire: false
  users:
    - {name: 9admin, password: password1, type: text}

create_hostname_file: true

fqdn: test-host.l.927.technology

hostname: test-host

packages:
  - jq
  - nano
  - qemu-guest-agent

package_update: true

prefer_fqdn_over_hostname: true

runcmd:
  - /bin/echo "*.* action(type=\"omfwd\" target=\"10.1.0.11\" port=\"514\" protocol=\"tcp\")" >> /etc/rsyslog.conf
  - /bin/systemctl restart rsyslog
  - /bin/systemctl enable qemu-guest-agent
  - /bin/systemctl start qemu-guest-agent
  - /usr/local/bin/927/scripts/cloud_init.sh

ssh_pwauth: true

users:
  - default
  - name: 9admin
    shell: /bin/bash
    sudo: [ 'ALL=(ALL) NOPASSWD: ALL' ]
    ssh_authorized_keys:
    - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDmkT60u5RcDz9FaFQUQXM0PvK6soJYOvZqu4p8M9tDx88ofCY5CWLehBd7NX52STYCwmZqa0HzMHMsVpIdMnmNNDVL7lEiQzGCRI8EcOsNympkAxggnZOj4abwQZxs+a8an7fYWSc82syyoxClXo00CQzrP1SFKjgZSEk6p/PO+kAi8MpDe097WdenzoYIwH5fWheOt/HFAchGCwXKVgu6fUj4QdwZ9x0j03DZabbbT6Q6aPT/eb34hsLQIFivsAIioMzxGKbOmXWHAFdjIPyHU5EruzqT/pU/Zd5RL47QHsAgTcZB0BbTglBlATZoCteIPAV42Vq1cM3EtAoEFsH

write_files:
  - path: /usr/local/bin/927/scripts/cloud_init.sh
    content: |
      #!/bin/bash

      # functions
      date.now() {
        /bin/date +%'s'
      }

      # local variables
      _json="{}"

      # control variables
      _error_count=0
      _exit_code=3

      # main
      [[ ! -d /usr/local/etc/927 ]] && /bin/mkdir --parents /usr/local/etc/927

      _json=$( /bin/echo ${_json} | /bin/jq '.born.date |= '$( date.now ) )
      _json=$( /bin/echo ${_json} | /bin/jq '.born.hostname |= "'$( /bin/hostname --fqdn )'"' )

      /bin/echo ${_json} > /usr/local/etc/927/cloud_init.json

      # exit
      [[ ${_error_count} != 0 ]] && _exit_code=2 || _exit_code=0
      exit ${_exit_code}

    permissions: '0755'







cloud-config
hostname: ol9u6-template
manage_etc_hosts: true
fqdn: ol9u6-template
user: 9admin
password: $5$4WhYMXCr$OgW2YK3YuVnsG2K2a.OqMKgtijgC2NnbO4FhqF4zkd0
ssh_authorized_keys:
chpasswd:
  expire: False
users:
  - default
package_upgrade: true



EOF.default

qm set 105 --cicustom "vendor=local:snippets/927.yaml"
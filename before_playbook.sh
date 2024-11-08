#!/bin/bash

sudo dnf install python3-pip
python3 -m pip install ansible-navigator --user
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc


cat << EOF > ~/.vimrc
syntax on
autocmd FileType yaml setlocal ai nu sw=2 ts=2 et

EOF


mkdir ~/bin
echo "ansible-doc \$1 | sed -n '/^EXAMPLES:/,\$p' | more" > ~/bin/ande
chmod +x ~/bin/ande


cat << EOF > ~/.ansible-navigator.yml
ansible-navigator:
  playbook-artifact:
    enable: false
EOF


cat << EOF | sudo tee /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

# ansible configuration
192.168.10.9   workstation.lab.example.com  workstation
192.168.10.10  servera.lab.example.com      servera
192.168.10.11  serverb.lab.example.com      serverb
192.168.10.12  serverc.lab.example.com      serverc
192.168.10.13  serverd.lab.example.com      serverd

EOF


for i in {a..d}
do
    ssh-copy-id root@server${i}
    sleep 1
done

ssh-copy-id root@workstation

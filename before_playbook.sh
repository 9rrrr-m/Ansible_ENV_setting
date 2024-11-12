#!/bin/bash

# student 사용자의 sudo 권한을 설정합니다.
echo 'student  ALL=(ALL)  NOPASSWD: ALL' | sudo tee /etc/sudoers.d/student

# ansible-navigator 프로그램을 설치합니다.
sudo dnf install python3-pip
python3 -m pip install ansible-navigator --user
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# ~/.vimrc 설정 파일의 내용을 yaml 형식에 최적화 합니다.
cat << EOF > ~/.vimrc
syntax on
autocmd FileType yaml setlocal ai nu sw=2 ts=2 et

EOF

# ~/bin/ande 쉘 스크립트로 ansible-doc에서 모듈의 예제만 확인 가능합니다.
mkdir ~/bin
echo "ansible-doc \$1 | sed -n '/^EXAMPLES:/,\$p' | more" > ~/bin/ande
chmod +x ~/bin/ande

# ~/.ansible-navigator.yml 설정 파일의 내용에 playbook-artifact 생성 옵션을 false로 지정합니다.
cat << EOF > ~/.ansible-navigator.yml
ansible-navigator:
  playbook-artifact:
    enable: false
EOF

# workstation의 /etc/hosts 파일에 관리호스트 정보를 추가합니다.
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

# 각 관리호스트의 root에 제어노드 student 계정의 ssh public key를 배포합니다.
for i in {a..d}
do
    ssh-copy-id root@server${i}
    sleep 1
done

ssh-copy-id root@workstation

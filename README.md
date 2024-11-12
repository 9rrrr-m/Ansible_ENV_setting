## 🖥 Ansible_ENV_setting

#### [ansible-navigator] 환경을 설정해주는 환경 세팅 프로그램입니다.

  💜 제작자: 9rrrr-m

  💜 Contact: 9rrrrm@gmail.com


#
## ❓ 사용 방법   

#### 아래 순서대로 작업을 진행합니다.

1. 각 제어 노드 및 관리 노드 네트워크 설정
    - 제어 노드

      ```
      IP: 192.168.10.9/24   HOSTNAME: workstation.lab.example.com
      ```
    - 관리 노드

      ```
      IP: 192.168.10.10/24  HOSTNAME: servera.lab.example.com
      IP: 192.168.10.11/24  HOSTNAME: serverb.lab.example.com
      IP: 192.168.10.12/24  HOSTNAME: serverc.lab.example.com
      IP: 192.168.10.13/24  HOSTNAME: serverd.lab.example.com
      ```
    - SEARCH_DOMAINS: lab.example.com
    - GATEWAY: 192.168.10.2
    - DNS: 192.168.10.2


2. 제어 노드에 student 계정 생성 및 wheel 그룹에 추가
    ```
    useradd -G wheel student
    passwd student
    ```
3. student 계정으로 로그인
4. ssh public key 생성
    ```
    ssh-keygen
    ```
5. git repository clone
    ```
    git clone https://github.com/9rrrr-m/Ansible_ENV_setting.git
    ```
6. Ansible_ENV_setting 디렉토리로 이동
    ```
    cd Ansible_ENV_setting
    ```
7. before_playbook.sh 실행
    ```
    chmod +x before_playbook.sh
    ./before_playbook.sh
    ```

    - student 사용자의 sudo 권한을 설정합니다.
    - ansible-navigator 프로그램을 설치합니다.
    - ~/.vimrc 설정 파일의 내용을 yaml 형식에 최적화 합니다.
    - ~/bin/ande 쉘 스크립트로 ansible-doc에서 모듈의 예제만 확인 가능합니다.
    - ~/.ansible-navigator.yml 설정 파일의 내용에 playbook-artifact 생성 옵션을 false로 지정합니다.
    - workstation의 /etc/hosts 파일에 관리호스트 정보를 추가합니다.
    - 각 관리호스트의 root에 제어노드 student 계정의 ssh public key를 배포합니다.

8. playbook.yml 실행(ansible-navigator 이용)
    ```
    ansible-navigator run -m stdout playbook.yml
    ```

    - ansible 제어에 필요한 student 계정을 각 제어 노드에 생성합니다.
    - vars/secret.yml 파일에서 생성하고자 하는 user와 password 변수 설정이 가능합니다. 편리한 설정을 위해 vault-pass 설정을 하지 않았습니다.
    - 새로 생성한 사용자가 sudo 권한 상승시 password를 입력하지 않도록 설정합니다.
    - 생성한 사용자에게 제어노드 student 계정의 ssh public key를 배포합니다.

9. 기본적인 세팅이 완료되었습니다. **즐거운 play 되세요!** 🙋‍♀️


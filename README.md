# Spring-Lab-CICD

## AWS EC2 설정(실행 전)
```
sudo apt update

sudo apt install openjdk-17-jdk
```

```
sudo vi /etc/ssh/sshd_config

PubkeyAuthentication yes
PubkeyAcceptedKeyTypes=+ssh-rsa

sudo reboot
```

## Execution 
1.  Actions > Java with Gradle 선택

```
2. ssh-keygen -t rsa -b 4096 -C "{USER_EMAIL}"
```

```
3. cat /Users/{USER_NAME}/.ssh/id_rsa.pub | ssh -i {AWS EC2 Key-Pair Directory} ubuntu@{AWS EC2 IP Address} 'cat >> .ssh/authorized_keys'
(이렇게 하면 마지막 커서에 바로 이어붙어서 인식 못할 수 있음, 에디터에서 한 줄 띄어주기)
```

```
4. cat /Users/{USER_NAME}/.ssh/id_rsa
입력 후 나오는 PRIVATE KEY 복사하기
(-----BEGIN OPENSSH PRIVATE KEY----- 이 문구 포함 복사 시작)
(-----END OPENSSH PRIVATE KEY----- 이 문구 포함 복사 끝) (마지막 줄 공백 주의)
```

5. Settings > Secrets and variables > Actions > Repository secrets에 등록하기:
- HOST (AWS EC2 IP Address)
- PORT (SSH PORT(일반적으로 22))
- PRIVATE_KEY (위의 PRIVATE KEY)
- USERNAME (ubuntu)

### 유의사항
일반적으로는 Executable Jar, Plain Jar 두 개 생성이므로 Executable Jar만 생성되게끔 하기 위해 build.gradle에 추가하기:

```
  jar {
  enabled = false;
  }
```

### 개발 환경
- IDE: Intellij IDEA Ultimate

- OS: MacOS Sonoma 14.2

- Language: Java SE 17

- SDK: Java SE Devlopment Kit 17

- Application: SpringBoot 3.2.3 (Gradle)

- AWS EC2 AMI: Ubuntu 22.04.5 LTS
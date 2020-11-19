#!/bin/bash

# 미러 서버를 카카오 서버로 변경
echo '### MIRROR CHANGE ###'
sudo sed -i 's/ap-northeast-2.ec2.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

# APT 리스트 업데이트
echo '### APT UPDATE ###'
sudo apt-get -y update

# APT 리스트 업그레이드
echo '### APT UPGRADE ###'
sudo apt-get -y upgrade

# Apache Tomcat9 설치
echo '### TOMCAT9 INSTALL ###'
sudo apt-get -y install tomcat9

# MariaDB 설치
echo '### MARIADB INSTALL ###'
sudo apt-get -y install mariadb-server

# Utility 설치 (net-tools, vim)
echo '### UTILITY INSTALL ###'
sudo apt-get -y install net-tools vim

# 캐쉬 정리
echo '### APT CASH REMOVE ###'
sudo apt-get -y autoremove

# Tomcat9 webapps 디렉토리 권한변경
echo '### TOMCAT9 WEBAPPS PERMISSION CHANGE ###'
sudo chmod -R 777 /var/lib/tomcat9/webapps

# Tomcat9 포트 변경 (8080 -> 80)
echo '### TOMCAT9 PORT CHANGE (80) ###'
sudo sed -i 's/port="8080"/port="80"/g' /usr/share/tomcat9/etc/server.xml

# Tomcat9 서비스 재시작
echo '### TOMCAT9 RESTART ###'
sudo systemctl restart tomcat9

# MariaDB 외부접속 설정 (127.0.0.1 -> 0.0.0.0)
echo '### MARIADB BIND-ADDRESS CHANGE (0.0.0.0) ###'
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# MariaDB root 비밀번호 설정
echo '### MARIADB PASSWORD SET ###'
sudo mysql -uroot -e "set password for 'root'@'%' = password('java1004'); flush privileges;"

# MariaDB root계정 외부접속 설정
echo '### MARIADB ROOT PERMISSION SET ###'
sudo mysql -uroot -pjava1004 -e "grant all privileges on *.* to 'root'@'%'; flush privileges;"

# MariaDB 서비스 재시작
echo '### MARIADB RESTART ###'
sudo systemctl restart mariadb

# 설치 완료 안내 문구
clear
echo '### 설치가 완료되었습니다 ###'
cd
sudo rm -rf ./install.sh

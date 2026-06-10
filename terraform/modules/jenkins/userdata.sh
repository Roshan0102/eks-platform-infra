#!/bin/bash

set -euxo pipefail

LOG_FILE="/var/log/user-data.log"

exec > >(tee -a ${LOG_FILE})
exec 2>&1

echo "========== Starting Jenkins Server Bootstrap =========="

# ==========================================================

# System Update

# ==========================================================

dnf update -y
# Elasticsearch / SonarQube requirement
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
sysctl -p
# ==========================================================

# Install Base Packages

# ==========================================================

dnf install -y 
git 
wget 
unzip 
docker 
nginx 
java-21-amazon-corretto

# ==========================================================

# Start & Enable Docker

# ==========================================================

systemctl enable docker
systemctl start docker

# ==========================================================

# Install AWS CLI v2

# ==========================================================

cd /tmp

rm -rf aws awscliv2.zip

curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip

unzip -q awscliv2.zip

./aws/install --update

aws --version

# ==========================================================

# Install Jenkins

# ==========================================================

curl -fsSL 
https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key 
| rpm --import -

cat >/etc/yum.repos.d/jenkins.repo <<EOF
[jenkins]
name=Jenkins-stable
baseurl=https://pkg.jenkins.io/redhat-stable
gpgcheck=1
enabled=1
EOF

dnf install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# Wait for Jenkins startup

sleep 30

# ==========================================================

# Jenkins Docker Access

# ==========================================================

usermod -aG docker jenkins

systemctl restart docker

# ==========================================================

# Install Trivy (Official Repo Method)

# ==========================================================

rpm --import https://aquasecurity.github.io/trivy-repo/rpm/public.key

cat >/etc/yum.repos.d/trivy.repo <<EOF
[trivy]
name=Trivy Repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/\$basearch/
enabled=1
gpgcheck=1
gpgkey=https://aquasecurity.github.io/trivy-repo/rpm/public.key
EOF

dnf install -y trivy

trivy --version

# ==========================================================

# Start & Enable Nginx

# ==========================================================

systemctl enable nginx
systemctl start nginx

# ==========================================================

# Validation

# ==========================================================

echo "===== Service Status ====="

systemctl is-active docker
systemctl is-active nginx
systemctl is-active jenkins

echo "===== Versions ====="

docker --version
java -version
git --version
aws --version
trivy --version

echo "===== Jenkins Initial Password ====="

cat /var/lib/jenkins/secrets/initialAdminPassword || true

echo "========== Bootstrap Completed Successfully =========="

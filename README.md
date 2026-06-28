# 🌩️ Kubernetes-Native Cloud Platform Infrastructure

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

Welcome to the central Infrastructure as Code (IaC) repository for the Kubernetes-Native Cloud Project. This repository provisions a highly available, production-grade Kubernetes platform on AWS using Terraform, establishing the foundational cloud infrastructure and networking required to run and manage modern microservices architectures at scale.

## ✨ Key Features & Architecture

*   **🌐 Advanced Networking:** Custom VPC topology with public/private subnets, NAT gateways, and optimized routing tables.
*   **⚓ Amazon EKS Cluster:** A fully managed, scalable Kubernetes control plane with auto-scaling worker node groups.
*   **🗄️ Highly Available Database:** Provisioned **Postgres RDS with a Standby Replica (Multi-AZ)** for automated failover, zero data loss, and supreme resilience.
*   **🔐 Security First (IAM & IRSA):** Strict IAM roles and IAM Roles for Service Accounts (IRSA), specifically configured for secure secrets management via External Secrets Operator.
*   **🏗️ CI/CD & GitOps Ready:** Pre-configured infrastructure for Jenkins and Ingress routing for ArgoCD.
*   **💾 Persistent Storage:** Seamless AWS EBS CSI Driver integration for stateful workloads.
*   **🌍 DNS Management:** Route53 integration for automated DNS record lifecycle management.

## 📂 Repository Structure

*   `terraform/`: Contains all modularized Terraform code (`vpc`, `eks`, `iam`, `route53`, `ebs-csi`, `external-secrets-irsa`, `jenkins`) and environment-specific deployments.
*   `Kubernetes yaml files/`: Essential manifests for cluster bootstrapping, including ArgoCD Ingress configurations and Cert-Manager `ClusterIssuer` setups.

## 🔗 Related Repositories

This infrastructure repository works in tandem with our application and GitOps repositories to deliver a complete CI/CD lifecycle:

*   🏗️ **Infrastructure Repo (Current):** [Roshan0102/eks-platform-infra](https://github.com/Roshan0102/eks-platform-infra)
*   🚀 **GitOps & App Delivery Repo:** [Roshan0102/online-boutique-gitops](https://github.com/Roshan0102/online-boutique-gitops)

## 🚀 Getting Started

1.  Navigate to the specific environment directory (e.g., `terraform/environments/dev`).
2.  Initialize the Terraform backend: `terraform init`
3.  Review the infrastructure plan: `terraform plan`
4.  Apply the configuration: `terraform apply`

> **Note:** Ensure you have configured your AWS credentials and have the appropriate IAM permissions before running Terraform commands.

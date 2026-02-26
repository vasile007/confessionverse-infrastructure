ConfessionVerse – AWS Cloud Infrastructure (Terraform)

Production-grade cloud infrastructure designed and implemented using Terraform to provision and manage AWS resources for the ConfessionVerse platform.

This repository defines a secure, modular, and reproducible AWS environment following Infrastructure-as-Code best practices.

🏗 Architecture Overview
Current Implementation (Cost-Optimized Development Environment)

This environment is intentionally optimized for cost while maintaining production-aligned architecture patterns.

Architecture Diagram (Current)
Internet
   │
   ▼
Public Subnet
   │
   └── EC2 (Ubuntu)
         - Dockerized application
         - SSM-only access
         - Security Groups restricted
   │
   ▼
Private Subnets
   │
   └── Amazon RDS (PostgreSQL)
         - Not publicly accessible
         - Encrypted at rest
         - Security Group restricted
🔧 Infrastructure Components
Networking

Custom VPC

2 Public Subnets

2 Private Subnets

Internet Gateway

Route Tables (public/private separation)

Network segmentation enforced via CIDR

Compute

EC2 (Ubuntu 22.04)

Docker-based application hosting

IAM Role attached

SSM-only access (no SSH exposure)

Database

Amazon RDS (PostgreSQL)

Deployed in private subnets

Not publicly accessible

Security Group allows access only from EC2

Encryption at rest enabled

Automated backups configured (dev-optimized retention)

Security Model

No SSH (port 22 disabled)

Access via AWS Systems Manager (Session Manager)

Principle of least privilege IAM roles

Security Groups enforce strict inbound rules

Database isolated from public internet

🔐 Access Model (Hardened)

EC2 access is handled via:

AWS Systems Manager (SSM)

IAM Role: AmazonSSMManagedInstanceCore

No SSH keys

No exposed management ports

This eliminates public administrative attack surface.

📦 Infrastructure as Code

The entire infrastructure is provisioned using Terraform:

Modular structure

Reusable components

Version-controlled definitions

Declarative resource management

Project structure:

confessionverse-infrastructure/
│
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars (excluded from Git)
│
└── modules/
     ├── vpc/
     ├── security/
     ├── ec2/
     └── rds/
☁ Remote Terraform State

To follow production best practices, Terraform state is stored remotely.

Backend Configuration

S3 bucket (versioning enabled)

DynamoDB table for state locking

State file encryption enabled

Public access blocked

Benefits

Prevents state corruption

Enables team collaboration

Maintains infrastructure integrity

Follows enterprise DevOps standards

🚀 Deployment Workflow
Initialize
terraform init
Plan
terraform plan
Apply
terraform apply

Infrastructure is fully reproducible from code.

🧠 Production-Grade Architecture (Design Proposal)

The current setup is cost-optimized for development.
In a production-grade environment, the architecture would be extended as follows:

High Availability Layer

Application Load Balancer (ALB)

Auto Scaling Group (multiple EC2 instances)

Multi-AZ deployment

Outbound Internet for Private Subnets

NAT Gateway (for secure outbound traffic)

Private route table updates

Database Resilience

Multi-AZ RDS deployment

Automated failover

Increased backup retention

Security Enhancements

HTTPS via ACM

WAF integration

Centralized logging (CloudWatch)

VPC Flow Logs

Production Architecture Diagram (Proposed)
Internet
   │
   ▼
Application Load Balancer
   │
   ├── EC2 (AZ-a)
   └── EC2 (AZ-b)
         │
         ▼
     Private Subnets
         │
         └── RDS (Multi-AZ)
🛡 Design Principles

Separation of application and infrastructure layers

Infrastructure as Code

Least privilege access

Network isolation

Secure remote administration

Cost-aware cloud design

Scalable architecture planning

📌 Project Scope

This repository demonstrates:

Cloud infrastructure engineering

Secure AWS architecture design

Terraform modular design

Production-aligned networking

Infrastructure reproducibility

DevOps-ready state management

🔮 Future Improvements

CI/CD pipeline integration

Docker image publishing to AWS ECR

Automated deployment workflows

Monitoring & alerting (CloudWatch)

HTTPS + custom domain

Horizontal scaling

👤 Author

Designed and implemented as part of a full-stack cloud-native architecture project (ConfessionVerse).

This infrastructure complements:

Dockerized React frontend

Dockerized Spring Boot backend

Managed Amazon RDS database

Reverse proxy architecture

🏁 Summary

This project demonstrates the ability to:

Design and implement secure AWS infrastructure

Apply Infrastructure-as-Code principles

Separate application and infrastructure concerns

Optimize cost while planning for production scalability

Follow modern DevOps and Cloud Engineering practices

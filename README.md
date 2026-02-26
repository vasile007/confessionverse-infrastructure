ConfessionVerse – AWS Cloud Infrastructure (Terraform)

Production-grade AWS infrastructure provisioned using Terraform to support a fully containerized full-stack application with automated CI/CD deployment.

This repository defines a secure, modular, and reproducible cloud environment aligned with modern DevOps and Infrastructure-as-Code best practices.

🏗 Architecture Overview

Current implementation represents a production-aligned, cost-optimized single-instance architecture with automated container deployment.

Current Architecture

Internet
↓
Public Subnet
↓
EC2 (Ubuntu 22.04)

Docker runtime

Nginx container (port 80 exposed)

Spring Boot container (port 8082 internal)

IAM Role attached

SSM-only access (no SSH)

↓
Private Subnets
↓
Amazon RDS (MySQL 8)

Not publicly accessible

Encrypted at rest

Access restricted via Security Groups

☁ Infrastructure Components
Networking

Custom VPC

2 Public Subnets

2 Private Subnets

Internet Gateway

Public & Private Route Tables

CIDR-based network segmentation

Compute

EC2 (Ubuntu 22.04)

IAM Instance Profile

Docker runtime

Access exclusively via AWS Systems Manager (SSM)

No SSH port exposed

Database

Amazon RDS (MySQL 8)

Deployed in private subnets

Security Group allows access only from EC2

Encryption at rest (AWS KMS)

Automated backups enabled

Container Registry

Amazon ECR repositories

confessionverse-backend

confessionverse-frontend

EC2 authenticates via IAM Role (no static credentials)

🔐 Security Model

No SSH (port 22 closed)

Access via AWS Systems Manager (Session Manager)

IAM role-based authentication for ECR

Principle of least privilege

Database fully isolated from public internet

Security Groups enforce strict inbound rules

No AWS credentials stored on EC2

🔄 CI/CD Integration

Infrastructure supports automated application deployment.

Deployment flow:

Developer push (main branch)
↓
GitHub Actions
↓
Docker image build
↓
Push to Amazon ECR
↓
AWS Systems Manager remote command
↓
Container restart on EC2

No manual SSH.
No manual Docker commands.
Immutable container deployment model.

📦 Infrastructure as Code

Provisioned entirely using Terraform.

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
Features

Modular architecture

Reusable components

Declarative resource management

Idempotent provisioning

Version-controlled infrastructure

☁ Remote Terraform State

State management:

S3 bucket (versioning enabled)

DynamoDB table for state locking

State encryption enabled

Public access blocked

Benefits:

Prevents state corruption

Enables safe collaboration

Ensures infrastructure integrity

🎯 Design Principles

Infrastructure as Code

Immutable container deployment

Least privilege IAM

Network isolation

Secure remote administration (SSM)

Separation of infrastructure and application layers

Cost-aware cloud design

Production-aligned architecture patterns

📊 Current Capabilities

This infrastructure currently supports:

Fully containerized full-stack application

Automated CI/CD deployment

Secure IAM-based registry authentication

Private managed database

Hardened access model

Reproducible cloud environment

🔮 Evolution Path (Production Scale)

Designed for clean extension toward:

Application Load Balancer (ALB)

Auto Scaling Groups

HTTPS via ACM

Multi-AZ RDS deployment

CloudWatch centralized logging

Prometheus + Grafana monitoring

ECS or EKS orchestration

🏁 Summary

This project demonstrates the ability to:

Design and implement secure AWS infrastructure

Apply Infrastructure-as-Code principles

Integrate CI/CD with container registry workflows

Enforce hardened cloud security patterns

Build production-aligned cloud architecture

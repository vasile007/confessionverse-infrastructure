




# CONFESSIONVERSE – AWS CLOUD INFRASTRUCTURE (TERRAFORM)


Production-grade AWS infrastructure provisioned using Terraform to support a fully containerized full-stack application with automated CI/CD deployment, centralized logging, and infrastructure monitoring.

This repository defines a secure, modular, and reproducible cloud environment aligned with Infrastructure-as-Code and modern DevOps best practices.

---

# 🏗 Architecture Overview


<img width="800" height="600" alt="ConfessionVerse_Advanced_Cloud_Architecture_Clean" src="https://github.com/user-attachments/assets/1ead64a8-012c-4c7a-a031-945d48eb5005" />


Current implementation represents a **production-aligned, cost-optimized single-instance deployment model**.

## Runtime Flow

```id="arch1"
Internet
   │
   ▼
Public Subnet
   │
   ▼
EC2 (Ubuntu 22.04)
   │
   ├ Docker Runtime
   │
   ├ Nginx container (reverse proxy, port 80 exposed)
   │
   ├ Spring Boot container (internal port 8082)
   │
   ├ Monitoring Stack
   │   ├ Prometheus
   │   ├ Grafana
   │   ├ Node Exporter
   │   └ cAdvisor
   │
   ├ CloudWatch Agent (centralized logging)
   │
   └ IAM Role attached
        │
        └ Access via AWS Systems Manager (SSM only, no SSH)

Private Subnets
   │
   ▼
Amazon RDS (MySQL 8)
```

RDS database is:

* not publicly accessible
* encrypted at rest using AWS KMS
* accessible only through Security Groups from EC2

---

# ☁ Infrastructure Components

## Networking

* Custom VPC
* 2 Public Subnets
* 2 Private Subnets
* Internet Gateway
* Public & Private Route Tables
* CIDR-based network segmentation

---

## Compute

EC2 instance running:

* Ubuntu 22.04
* Docker runtime
* Containerized application services
* IAM Instance Profile
* AWS Systems Manager access

Key characteristics:

* **No SSH exposure**
* Access managed through **AWS Systems Manager Session Manager**
* Instance authenticates to AWS services using IAM role

---

## Database

Amazon RDS (MySQL 8)

* deployed in private subnets
* not publicly accessible
* encrypted at rest using AWS KMS
* automated backups enabled
* Security Group allows access **only from EC2 instance**

---

## Container Registry

Amazon ECR repositories:

```
confessionverse-backend
confessionverse-frontend
```

EC2 authenticates using IAM role.

No static AWS credentials are stored on the instance.

---

# 🐳 Container Runtime

Application services run as Docker containers on the EC2 instance.

Containers are connected through a shared Docker network enabling internal service communication.

Deployment characteristics:

* stateless container deployment
* environment-based configuration
* automatic restart policy
* decoupled application services

---

# 📊 Monitoring Stack

Infrastructure includes a monitoring system based on **Prometheus and Grafana**.

Components deployed via Docker:

* **Prometheus** – metrics collection
* **Grafana** – dashboards and visualization
* **Node Exporter** – host system metrics
* **cAdvisor** – Docker container metrics

### Monitoring Dashboards

**Linux host monitoring (Node Exporter)**

<img width="1269" height="844" alt="Screenshot 2026-03-08 174406" src="https://github.com/user-attachments/assets/15053687-d3cd-4065-b314-ddc573f5d316" />


**Docker container monitoring**

<img width="1275" height="853" alt="Screenshot 2026-03-08 174421" src="https://github.com/user-attachments/assets/0fa7dd51-bf15-459a-8faa-e8759f3288b0" />


**Container metrics (cAdvisor)**

<img width="1271" height="853" alt="Screenshot 2026-03-08 174430" src="https://github.com/user-attachments/assets/a6b7a32f-99c6-47a5-af73-75e556124258" />


Grafana dashboard access:

```
http://SERVER_IP/grafana/
```

Monitoring provides visibility into:

* host resource usage
* Docker container performance
* system health metrics
* application runtime environment

---

# 📜 Centralized Logging

Logs are exported to **Amazon CloudWatch** using the CloudWatch Agent.

Docker container logs are streamed to CloudWatch, enabling:

* centralized log storage
* remote debugging
* production monitoring
* infrastructure observability

---

# 🔐 Security Model

Security architecture follows hardened cloud practices:

* Port 22 closed (no SSH)
* Access exclusively via AWS Systems Manager
* IAM role-based authentication for ECR
* Principle of least privilege applied
* Database fully isolated from the public internet
* Strict Security Group inbound rules
* No AWS credentials stored on EC2

---

# 🔄 CI/CD Deployment Architecture

Infrastructure supports automated container deployment.

## Deployment Flow

```id="deployflow"
Developer Push (main branch)
        │
        ▼
GitHub Actions
        │
        ▼
Docker Image Build
        │
        ▼
Push to Amazon ECR
        │
        ▼
Remote deployment via AWS Systems Manager
        │
        ▼
Container restart on EC2
```

Deployment model characteristics:

* no manual SSH
* no manual Docker commands
* immutable container deployment

---

# 📦 Infrastructure as Code

Infrastructure is provisioned entirely using **Terraform**.

## Project Structure

```id="tfstructure"
confessionverse-infrastructure/
│
├ main.tf
├ providers.tf
├ variables.tf
├ outputs.tf
├ terraform.tfvars (excluded from Git)
│
└ modules/
   ├ vpc/
   ├ security/
   ├ ec2/
   └ rds/
```

## Features

* modular architecture
* reusable components
* declarative resource management
* idempotent provisioning
* version-controlled infrastructure

---

# ☁ Remote Terraform State

Terraform state management:

* S3 bucket (versioning enabled)
* DynamoDB table for state locking
* state encryption enabled
* public access blocked

Benefits:

* prevents state corruption
* enables safe collaboration
* ensures infrastructure integrity

---

# 🎯 Design Principles

* Infrastructure as Code
* immutable container deployment
* least privilege IAM
* network isolation
* secure remote administration (SSM)
* separation of infrastructure and application layers
* cost-aware cloud design
* production-aligned architecture patterns

---

# 📊 Current Capabilities

This infrastructure supports:

* fully containerized full-stack deployment
* automated CI/CD integration
* secure IAM-based registry authentication
* private managed database
* centralized logging with CloudWatch
* container monitoring with Prometheus and Grafana
* hardened access model
* reproducible cloud environment

---

# 🔮 Evolution Path (Production Scale)

Infrastructure is designed to evolve toward:

* Application Load Balancer (ALB)
* Auto Scaling Groups
* HTTPS via AWS ACM
* Multi-AZ RDS deployment
* distributed container orchestration (ECS/EKS)
* enhanced monitoring and alerting
* scalable microservice architecture

---

# 🏁 Summary

This project demonstrates the ability to:

* design and implement secure AWS infrastructure
* apply Infrastructure-as-Code principles
* integrate CI/CD with container registry workflows
* implement centralized logging and monitoring
* enforce hardened cloud security patterns
* build production-aligned cloud architecture

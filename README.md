




# Confessionverse – Full AWS Cloud Infrastructure & CI/CD


Production-grade AWS infrastructure provisioned using Terraform to support a fully containerized full-stack application.

Includes automated CI/CD deployment, centralized logging, infrastructure monitoring, and a live cloud environment.


## 🌐 Live Environment (In Development)

https://confessionverse.live

The application is deployed in a live cloud environment and continuously updated via CI/CD.

Note:
This environment is actively under development and testing. Some features (e.g. payments, integrations) are not fully finalized.



---

# 🏗 Architecture Overview



<img width="1413" height="1113" alt="infrastructure-diagram" src="https://github.com/user-attachments/assets/b2458101-9c3d-4a68-a79c-54d9abc6875a" />


## 🚀 Deploy Infrastructure

Initialize Terraform:

terraform init

Plan infrastructure:

terraform plan

Apply infrastructure:

terraform apply


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
        └ Access via SSH (key-based authentication) and AWS Systems Manager (optional)

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

## ⚙️ Technology Stack

Infrastructure:
- AWS (VPC, EC2, RDS, IAM, SSM, ECR)
- Terraform

Containers:
- Docker
- Nginx
- Spring Boot

Monitoring:
- Prometheus
- Grafana
- Node Exporter
- cAdvisor

Logging:
- Amazon CloudWatch

CI/CD:
- GitHub Actions

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

# 📊 Monitoring Stack and Screenshots

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

* SSH access enabled with key-based authentication
* Access can also be managed via AWS Systems Manager
* IAM role-based authentication for ECR
* Principle of least privilege applied
* Database fully isolated from the public internet
* Strict Security Group inbound rules
* No AWS credentials stored on EC2

---

### 🔄 CI/CD Deployment (Production)

Deployment is fully automated using GitHub Actions.

#### Flow

```text
git push
   │
   ▼
GitHub Actions
   │
   ▼
SSH
   │
   ▼
EC2
   │
   ▼
docker-compose up -d --build
```

#### Key Features

* SSH-based secure deployment (key authentication)
* No manual server interaction
* Automatic container rebuild and restart
* Infrastructure and application fully decoupled
* 
Deployment Behavior
Zero-downtime oriented deployment (no full stack shutdown)
Services updated incrementally via Docker Compose
---


## 🖥 Production Server Setup

* EC2 (Ubuntu 22.04)
* Docker & Docker Compose
* Nginx reverse proxy with HTTPS (Let's Encrypt)
* Firewall configured (ports 80, 443, 22)
* Automated cleanup via cron jobs
* Docker log rotation configured


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


## 🧹 Maintenance & Stability

* Automated Docker cleanup (cron job)
* Log size limits configured to prevent disk overflow
* Resource-efficient single-instance deployment
* System designed for long-running uptime stability


# 🏁 Summary

This project demonstrates the ability to:

* design and implement secure AWS infrastructure
* apply Infrastructure-as-Code principles
* integrate CI/CD with container registry workflows
* implement centralized logging and monitoring
* enforce hardened cloud security patterns
* build production-aligned cloud architecture


  💰 Cost Considerations

Infrastructure designed for low-cost experimentation and learning environments using small instance types and single-instance deployment.


## ⚠️ Production Notes

Current architecture is optimized for learning and cost efficiency.

Trade-offs:

* Single EC2 instance (no high availability)
* No load balancing
* Minimal redundancy

Designed to evolve into:

* Load balanced architecture (ALB)
* Auto Scaling
* Container orchestration (ECS/EKS)


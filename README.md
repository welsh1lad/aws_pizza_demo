# aws_pizza_demo
Aws Demo that touches most areas of Devops Develpment
# 🍕 Pizza Order System – CI/CD Demo Project

This repository demonstrates my **DevOps, Cloud, and CI/CD skills** using a fun "Pizza Ordering System" scenario.  
It showcases **Terraform for AWS infrastructure**, **GitLab CI/CD for automation**, and **Kubernetes (EKS)** for application deployment.  

---

## 🚀 Project Overview

1. **Pizza Order App** (EKS pod)  
   - Simple web UI + backend API to place an order.  
   - Sends the order to an AWS **SQS queue (`pizza-orders`)**.  

2. **Lambda Function** (AWS Services VPC)  
   - Triggered by SQS messages.  
   - Processes the order step-by-step:  
     - Order received  
     - Pizza cooking  
     - Pizza preparing  
     - Ready for collection  
   - Posts status updates to **SQS (`pizza-status`)**.  

3. **Pizza Status App** (EKS pod)  
   - Displays a **donut chart** of the order progress.  
   - Fetches messages from the `pizza-status` queue.  

4. **Networking**  
   - Two isolated VPCs:  
     - **App VPC** → Runs EKS + ALB ingress.  
     - **Services VPC** → Runs Lambda + SQS.  
   - Connected via **VPC peering**.  

---

## 🏗️ Architecture Diagram

```mermaid
flowchart LR
    subgraph AppVPC["App VPC (EKS Cluster)"]
        A1["🍕 Order App (Frontend + API)"]
        A2["📊 Status App (Frontend)"]
        ALB["Application Load Balancer (Ingress)"]
        ALB --> A1
        ALB --> A2
    end

    subgraph ServicesVPC["Services VPC (Lambda + SQS)"]
        SQS1["📥 SQS Queue: pizza-orders"]
        SQS2["📤 SQS Queue: pizza-status"]
        LAMBDA["⚡ Lambda Function (process order)"]

        LAMBDA -->|status updates| SQS2
        SQS1 -->|trigger| LAMBDA
    end

    A1 -->|send order| SQS1
    A2 -->|poll status| SQS2

    AppVPC <-. VPC Peering .-> ServicesVPC


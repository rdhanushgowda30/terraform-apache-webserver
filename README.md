# Terraform Apache Webserver Project

This repository contains Terraform code to deploy an Apache webserver on AWS EC2.  
It documents the complete journey of how I built the project, step by step, as a beginner in Cloud and DevOps.

---

## 📖 Project Journey (Step by Step)

### 1. Setting Up the Environment
- I launched an **Ubuntu EC2 instance** to use as my development machine.
- Installed **Terraform** on the instance.
- Configured AWS CLI with IAM credentials using `aws configure`.
- Created a project folder called `terraform-apache-webserver`.

---

### 2. Creating Terraform Files
Inside the project folder, I created three files:
- **provider.tf** → to configure the AWS provider and region.
- **main.tf** → to define the EC2 instance, security group, and Apache installation.
- **output.tf** → to print the public IP/DNS of the instance.

---

### 3. Writing Provider Configuration
In the provider file, I specified the AWS provider and region (for example, `us-east-1`).  
This tells Terraform which cloud provider to use and where to deploy resources.

---

### 4. Defining EC2 Instance + Apache Setup
In the main file, I:
- Created a **Security Group** that allows inbound HTTP traffic on port 80.
- Defined an **EC2 instance** using a free‑tier Ubuntu AMI (`t2.micro`).
- Added a **user_data script** that automatically installs Apache, starts the service, and places a simple HTML page saying *“Hello from Terraform Apache Server”*.

This ensures that as soon as the EC2 instance is launched, Apache is ready without manual setup.

---

### 5. Adding Outputs
In the outputs file, I configured Terraform to display:
- The **public IP address** of the EC2 instance.
- The **public DNS name** of the EC2 instance.

This makes it easy to know where to access the webserver after deployment.

---

### 6. Initializing Terraform
I ran:
- `terraform init` → to download the AWS provider plugin.
- `terraform validate` → to check if the configuration was correct.

---

### 7. Applying the Configuration
I executed:
- `terraform apply` → to create the infrastructure.
- Confirmed with `yes` when prompted.

Terraform then provisioned the EC2 instance and security group automatically.

---

### 8. Verifying Apache Webserver
After Terraform finished, it printed the public IP of the EC2 instance.  
I opened the IP in a browser and saw the message:

This confirmed that Apache was successfully installed and serving content.

---

### 9. Setting Up GitHub Repository
- Initialized Git in the project folder.
- Added a `.gitignore` file to exclude `.terraform/` and `*.tfstate` files.
- Committed only the Terraform code and README.md.
- Linked the local repo to GitHub (`terraform-apache-webserver`) and pushed the project.

---

## 🚀 How to Run This Project

1. Clone the repository:
   ```bash
   git clone https://github.com/rdhanushgowda30/terraform-apache-webserver.git
   cd terraform-apache-webserver


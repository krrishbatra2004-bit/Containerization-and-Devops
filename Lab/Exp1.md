# **Lab Manual – Experiment 1**

Comparison of Virtual Machines (VMs) and Containers using Ubuntu and Nginx.

---
**Name:** Krrish Batra

**SAP ID:** 500119657

**Batch:** 2

**Specialisation:** Cloud Computing and Virtualization Technology

---

## **Software and Hardware Requirements**

### **Hardware**

* 64-bit system with virtualization support enabled in BIOS
* Minimum 8 GB RAM (4 GB minimum acceptable)
* Internet Connection

### **Software (Windows Host)**

* Oracle VirtualBox
* Vagrant
* Windows Subsystem for Linux (WSL 2)
* Ubuntu (WSL distribution)
* Docker Engine (docker.io)

---

## **Theory**

### **Virtual Machine**

A Virtual Machine emulates a complete physical computer, including its own operating system kernel, hardware drivers, and user space. Each VM runs on top of a hypervisor.

**Characteristics:**

* Full OS per VM
* Higher resource usage
* Strong isolation
* Slower startup time

### **Container**

Containers virtualize at the operating system level. They share the host OS kernel while isolating applications and dependencies in user space.

**Characteristics:**

* Shared kernel
* Lightweight
* Fast startup
* Efficient resource usage

---

## **Experiment Setup – Part A: Virtual Machine (Windows)**

### **Step 1: Install VirtualBox**

1. Download VirtualBox from the official website.
2. Run the installer and keep default options.
3. Restart the system if prompted.

**Screenshot 1:** VirtualBox Installation

```
[INSERT SCREENSHOT: VirtualBox installation completed]
```

---

### **Step 2: Install Vagrant**

1. Download Vagrant for Windows.
2. Install using default settings.
3. Verify installation:

   ```bash
   vagrant --version
   ```

**Screenshot 2:** Vagrant Version Check

```
[INSERT SCREENSHOT: Terminal showing vagrant version output]
```

---

### **Step 3: Create Ubuntu VM using Vagrant**

1. Create a new directory:

   ```bash
   mkdir vm-lab
   cd vm-lab
   ```

2. Initialize Vagrant with Ubuntu box:

   ```bash
   vagrant init ubuntu/jammy64
   ```

3. Start the VM:

   ```bash
   vagrant up
   ```

**Screenshot 3:** Vagrant Up Process

```
[INSERT SCREENSHOT: Terminal showing vagrant up command and VM creation]
```

1. Access the VM:

   ```bash
   vagrant ssh
   ```

**Screenshot 4:** SSH into VM

```
[INSERT SCREENSHOT: Successfully connected to VM via SSH]
```

---

### **Step 4: Install Nginx inside VM**

```bash
sudo apt update
sudo apt install -y nginx
sudo systemctl start nginx
```

**Screenshot 5:** Nginx Installation in VM

```
[INSERT SCREENSHOT: Nginx installation process and completion]
```

---

### **Step 5: Verify Nginx**

```bash
curl localhost
```

**Screenshot 6:** Nginx Verification in VM

```
[INSERT SCREENSHOT: curl output showing Nginx welcome page HTML]
```

---

### **Step 6: Stop and Remove VM**

```bash
vagrant halt
vagrant destroy
```

**Screenshot 7:** VM Cleanup

```
[INSERT SCREENSHOT: Vagrant halt and destroy commands]
```

---

## **Experiment Setup – Part B: Containers using WSL (Windows)**

### **Step 1: Install WSL 2**

```powershell
wsl --install
```

Reboot the system after installation.

**Screenshot 8:** WSL Installation

```
[INSERT SCREENSHOT: PowerShell showing WSL installation]
```

---

### **Step 2: Install Ubuntu on WSL**

```powershell
wsl --install -d Ubuntu
```

**Screenshot 9:** Ubuntu on WSL Setup

```
[INSERT SCREENSHOT: Ubuntu installation on WSL]
```

---

### **Step 3: Install Docker Engine inside WSL**

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo usermod -aG docker $USER
```

Logout and login again to apply group changes.

**Screenshot 10:** Docker Installation in WSL

```
[INSERT SCREENSHOT: Docker installation process]
```

**Screenshot 11:** Docker Version Check

```
[INSERT SCREENSHOT: docker --version output]
```

---

### **Step 4: Run Ubuntu Container with Nginx**

```bash
docker pull ubuntu

docker run -d -p 8080:80 --name nginx-container nginx
```

**Screenshot 12:** Docker Pull and Run

```
[INSERT SCREENSHOT: Docker pull nginx and docker run command]
```

**Screenshot 13:** Container Running Status

```
[INSERT SCREENSHOT: docker ps showing nginx-container running]
```

---

### **Step 5: Verify Nginx in Container**

```bash
curl localhost:8080
```

**Screenshot 14:** Nginx Verification in Container

```
[INSERT SCREENSHOT: curl output showing Nginx welcome page from container]
```

---

## **Resource Utilization Observation**

### **VM Observation Commands**

```bash
free -h
htop
systemd-analyze
```

**Screenshot 15:** VM Resource Usage

```
[INSERT SCREENSHOT: free -h output in VM]
```

**Screenshot 16:** VM Boot Time Analysis

```
[INSERT SCREENSHOT: systemd-analyze output]
```

---

### **Container Observation Commands**

```bash
docker stats
free -h
```

**Screenshot 17:** Container Resource Usage

```
[INSERT SCREENSHOT: docker stats output]
```

**Screenshot 18:** Host System Resource Usage

```
[INSERT SCREENSHOT: free -h output on host with container running]
```

---

### **Parameters to Compare**

| Parameter    | Virtual Machine | Container |
| ------------ | --------------- | --------- |
| Boot Time    | High            | Very Low  |
| RAM Usage    | High            | Low       |
| CPU Overhead | Higher          | Minimal   |
| Disk Usage   | Larger          | Smaller   |
| Isolation    | Strong          | Moderate  |

**Screenshot 19:** Resource Comparison Chart

---

## **Observations**

### **Virtual Machine Observations:**

```
[INSERT YOUR OBSERVATIONS]
- Boot time: ___ seconds
- RAM usage: ___ MB
- Disk space: ___ GB
- CPU usage: ___% 
```

### **Container Observations:**

```
[INSERT YOUR OBSERVATIONS]
- Startup time: ___ seconds
- RAM usage: ___ MB
- Disk space: ___ MB
- CPU usage: ___%
```

---

## **Result**

The experiment demonstrates that containers are significantly more lightweight and resource-efficient compared to virtual machines, while virtual machines provide stronger isolation and full OS-level abstraction.

Virtual Machine:

* Resource overhead: High
* Isolation: Strong

Container:

* Resource overhead: Minimal
* Isolation: Good



---

## **Conclusion**

Virtual Machines are suitable for full OS isolation and legacy workloads, whereas Containers are ideal for microservices, rapid deployment, and efficient resource utilization.

## **References**

1. VirtualBox Documentation - https://www.virtualbox.org/manual/
2. Vagrant Documentation - https://www.vagrantup.com/docs
3. Docker Official Documentation - https://docs.docker.com/

---


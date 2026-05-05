# Lab 10: Static Application Security Testing (SAST) with SonarQube

![SonarQube Banner](https://docs.sonarsource.com/images/sonarqube-logo.svg)

## Overview

This laboratory experiment focuses on integrating **SonarQube** into our DevOps workflow. SonarQube is an open-source platform that continuously inspects code quality by automatically scanning source code for:
- **Bugs** (Reliability issues)
- **Vulnerabilities** (Security issues)
- **Code Smells** (Maintainability issues)

By establishing a "Quality Gate", teams can enforce that only clean, secure, and maintainable code is merged and deployed.

---

## Architecture

The SonarQube ecosystem consists of two primary components:

1. **SonarQube Server ("The Brain")**: A central web application backed by a database (PostgreSQL). It stores the rules, processes the analysis reports, and provides the dashboard interface.
2. **Sonar Scanner ("The Worker")**: A lightweight CLI tool or build-system plugin (like Maven or Gradle) that reads the local source code, analyzes it against the server's rules, and pushes the results back to the server.

**Workflow**: `Local Code / CI Pipeline` → `Sonar Scanner` → `SonarQube Server` → `Quality Dashboard`

---

## Key Concepts

| Term | Description |
| :--- | :--- |
| **Quality Gate** | A set of boolean rules (e.g., "Code Coverage > 80%") that a project must pass before it can be deployed. |
| **Bug** | A coding error that will produce an incorrect or unexpected result at runtime. |
| **Vulnerability** | A security weakness that can be exploited by an attacker. |
| **Code Smell** | Poorly designed or written code that is difficult to maintain and understand. |
| **Technical Debt**| The estimated time required to fix all current bugs, vulnerabilities, and code smells. |

---

## Getting Started

Follow these steps to deploy your local SonarQube environment using Docker.

### Prerequisites
- Docker & Docker Compose installed
- A sample Java/Maven project (to run the scanner against)
- At least 2GB of RAM allocated to Docker (SonarQube uses Elasticsearch internally and requires memory)

### Step 1: Start the SonarQube Environment

We use a `docker-compose.yml` file to spin up both the SonarQube server and its PostgreSQL database.

1. Navigate to the `Exp10` directory.
2. Run the following command to start the services in the background:
   ```bash
   docker-compose up -d
   ```
3. Wait approximately 1-2 minutes for the server to fully initialize.

### Step 2: Access the Dashboard

1. Open your browser and navigate to: `http://localhost:9000`
2. Log in with the default credentials:
   - **Login**: `admin`
   - **Password**: `admin`
3. You will be prompted to change your password upon first login.
4. Generate a **User Token** from the Security settings. You will need this token for the scanner.

### Step 3: Run the Sonar Scanner

Navigate to any sample Maven project on your machine and run the Sonar scanner plugin, injecting the token you just created:

```bash
mvn clean verify sonar:sonar -Dsonar.login=YOUR_GENERATED_TOKEN
```

### Step 4: View Results
Go back to `http://localhost:9000`. You will see your project listed with a full report on Bugs, Vulnerabilities, and Code Smells!

---

## ⚙️ CI/CD Integration (Jenkins Example)

In a production environment, SonarQube is typically triggered automatically by a CI server like Jenkins whenever code is pushed.

```groovy
pipeline {
    agent any
    stages {
        stage('Build & Test') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                // Requires the SonarQube Jenkins Plugin to be configured
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Quality Gate') {
            steps {
                // Wait for the server to process the report and return Pass/Fail
                waitForQualityGate abortPipeline: true
            }
        }
    }
}
```

## 🌟 Best Practices

- **Scan Early and Often**: Integrate scanning into Pull Requests so issues are caught before they merge into the main branch.
- **Enforce Quality Gates**: Block deployments automatically if the code fails the Quality Gate.
- **Zero Technical Debt**: Adopt a "Clean as You Code" methodology—always fix new issues immediately rather than letting them pile up.
- **Secure Credentials**: Never hardcode your SonarQube tokens in your scripts; use secret managers or Jenkins Credentials.

# Lab-10: SonarQube 

## 1. Theory

### What is SonarQube?
SonarQube is an open-source platform that automatically scans source code for **bugs**, **security vulnerabilities**, and **maintainability issues**. This is known as **Static Application Security Testing (SAST)**.

### Key Concepts
| Term | Description |
| :--- | :--- |
| **Quality Gate** | Rules that code must pass before deployment. |
| **Bug** | Code likely to break at runtime. |
| **Vulnerability** | A security weakness. |
| **Code Smell** | Poorly written code that is hard to maintain. |
| **Technical Debt**| Time required to fix all current issues. |

---

## 2. Lab Architecture

1.  **SonarQube Server ("The Brain")**: A web app that receives reports and applies rules.
2.  **Sonar Scanner ("The Worker")**: A CLI tool that reads code and sends reports to the server.

**Flow**: `Your Code` → `Sonar Scanner` → `SonarQube Server` → `Dashboard`.

---

## 3. Hands-on Lab

### Step 1: Start the SonarQube Server
Create a `docker-compose.yml` file:
```yaml
version: '3.8'
services:
  sonar-db:
    image: postgres:13
    environment:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: sonar
  sonarqube:
    image: sonarqube:lts-community
    ports:
      - "9000:9000"
    depends_on:
      - sonar-db
```
**Start**: `docker-compose up -d`
![SonarQube Server Initialization](images/image1.png)
![SonarQube Login Page](images/image2.png)

### Step 2: Run the Scanner
Run analysis using the Maven plugin:
```bash
mvn sonar:sonar -Dsonar.login=YOUR_TOKEN
```
![Project Configuration & Token Generation](images/image3.png)
![Scanner Configuration](images/image4.png)
![Scanner Execution in Terminal](images/image5.png)

### Step 3: View Results
Open `http://localhost:9000` to see the report.
![SonarQube Dashboard Results](images/image6.png)
![Project Quality Gate & Analysis](images/image7.png)

---

## 4. Integration & Best Practices

### CI/CD Integration (Jenkins)
```groovy
stage('SonarQube Analysis') {
    steps {
        withSonarQubeEnv('SonarQube') {
            sh 'mvn clean verify sonar:sonar'
        }
    }
}
```

### Best Practices
- **Scan Early**: Scan every Pull Request.
- **Enforce Quality Gates**: Block deployments if rules fail.
- **Zero Technical Debt**: Fix issues immediately.
- **Security**: Use secret managers for tokens.


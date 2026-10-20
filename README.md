
# Azure AIOps and MLOps Platform

## Overview
This project demonstrates an Azure-based AIOps and MLOps solution using Terraform, Python, and machine learning to identify unusual operational metrics and generate severity-based alerts.

## Architecture
1. Generate synthetic operational metrics.
2. Store metrics in CSV format for the local demo.
3. Train an Isolation Forest anomaly detection model.
4. Detect anomalous CPU, memory, response-time, and error-rate metrics.
5. Generate severity-based alerts.
6. Provision Azure monitoring infrastructure using Terraform.
7. Validate code with automated tests.
8. Integrate Git and CI/CD in a later phase.

## Technology Stack
- Microsoft Azure
- Terraform
- Python
- Pandas and NumPy
- Scikit-learn
- Joblib
- Pytest
- Git
- Azure Monitor
- Log Analytics Workspace

## Project Structure
- `environments/dev/` - Terraform development environment
- `modules/resource-group/` - Resource group module
- `modules/storage/` - Storage account module
- `modules/monitoring/` - Log Analytics module
- `modules/monitor-alert/` - Metric alert module
- `modules/action-group/` - Alert notification action group
- `src/generate_metrics.py` - Generate synthetic metrics
- `src/train_model.py` - Train the anomaly detection model
- `src/detect_anomalies.py` - Detect anomalies
- `src/alerting.py` - Generate severity-based alerts
- `tests/` - Automated tests
- `data/` - Generated metric and alert CSV files
- `models/` - Trained model artifacts

## Local Setup
Create and activate a Python virtual environment, then install dependencies:

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
```

## Run the ML Workflow

```powershell
python src/generate_metrics.py
python src/train_model.py
python src/detect_anomalies.py
python src/alerting.py
```

## Run Tests

```powershell
python -m pytest tests/ -v
```

## Terraform Validation

Run from the development environment directory:

```powershell
terraform fmt -recursive
terraform init
terraform validate
```

## Security Notes
- Do not commit credentials, secrets, Terraform state files, or local environment files.
- Use secure authentication and secret management for CI/CD.
- Review the Terraform plan before deploying infrastructure.

## Current Scope
The Python anomaly detection workflow and automated tests are implemented. Terraform modules define the Azure monitoring infrastructure. Actual Azure deployment, real notification delivery, and CI/CD integration are planned for later phases.

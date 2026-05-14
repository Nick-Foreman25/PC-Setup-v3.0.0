# PC Setup v3.0.0

## Overview

PC Setup v3.0.0 is a PowerShell-based workstation deployment and provisioning platform designed to automate the installation and configuration of enterprise software, infrastructure utilities, and supporting system components for Windows environments.

The platform was developed to reduce manual deployment time, standardize workstation builds, and streamline technician workflows across infrastructure and support operations.

This project represents a legacy deployment framework prior to migration toward a more modular PC Deployment architecture.

---

# Features

- Automated workstation provisioning
- Silent application installations
- SQL Server deployment support
- UniFi Controller deployment support
- Enterprise utility deployment
- PowerShell-based automation
- Configuration-driven deployment logic
- Reduced setup and onboarding time
- Standardized deployment process
- Logging and troubleshooting support

---

# Technologies Used

- PowerShell
- Windows Batch Scripting
- JSON Configuration Files
- Windows Installer Packages (MSI/EXE)
- Windows Administration Utilities

---

# Project Structure

```text
PC_Setup_v3.0.0/
│
├── Config/
│   └── config.json
│
├── Scripts/
│   ├── Install.ps1
│   ├── SQLInstall.ps1
│   ├── UnifiInstall.ps1
│   └── Validation.ps1
│
├── Modules/
│   ├── Logging.psm1
│   └── Validation.psm1
│
├── Packages/
│   └── (Installer binaries not included in repository)
│
├── Logs/
│
├── README.md
└── .gitignore
```

---

# Requirements

## Operating System

- Windows 10 Pro
- Windows 11 Pro
- Windows Server 2019/2022 (optional support)

---

## PowerShell

- PowerShell 5.1 or later

Verify version:

```powershell
$PSVersionTable.PSVersion
```

---

## Required Permissions

- Local Administrator privileges
- Execution policy allowing script execution

Example:

```powershell
Set-ExecutionPolicy Bypass -Scope Process
```

---

# Required Installers

Installer binaries are intentionally NOT stored inside the GitHub repository due to GitHub file size limitations and enterprise deployment best practices.

The following installers must be manually downloaded and placed into the `Packages` directory before running deployment scripts.

---

# SQL Server Components

## Microsoft SQL Server

Download:
- SQL Server Express / Developer / Standard
- SQL Management Studio (SSMS)

Official Source:

[Microsoft SQL Server Downloads](https://www.microsoft.com/en-us/sql-server/sql-server-downloads?utm_source=chatgpt.com)

Example Package Structure:

```text
Packages/
└── SQL/
    ├── SQLEXPR_x64_ENU.exe
    └── SSMS-Setup-ENU.exe
```

---

# UniFi Controller Components

## UniFi Network Application

Official Source:

[Ubiquiti UniFi Downloads](https://ui.com/download?utm_source=chatgpt.com)

Required Components:
- UniFi Network Application
- Java Runtime (if required for selected UniFi version)

Example Package Structure:

```text
Packages/
└── Unifi/
    ├── unifi-installer.exe
    └── Java11.msi
```

---

# Google Chrome

Official Source:

[Google Chrome Enterprise Download](https://chromeenterprise.google/browser/download/?utm_source=chatgpt.com)

Example Package Structure:

```text
Packages/
└── Chrome/
    └── ChromeOfflineInstaller.exe
```

---

# ECS Toolkit

Internal or vendor-specific toolkit installers should be placed into:

```text
Packages/
└── ECS/
    └── TOOLKIT_SETUP.exe
```

---

# Installation

## Clone Repository

```powershell
git clone https://github.com/Nick-Foreman25/PC-Setup-v3.0.0.git
```

---

## Navigate to Project Directory

```powershell
cd PC_Setup-v3.0.0
```

---

## Populate Packages Directory

Download required installers and place them into their respective directories under `Packages/`.

---

## Run Deployment Script

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\Scripts\Install.ps1
```

---

# Example Deployment Tasks

The deployment platform can automate:

- Google Chrome installation
- SQL Server installation
- SQL Management Studio deployment
- UniFi Network Application deployment
- Java Runtime installation
- Enterprise toolkit installation
- System configuration tasks
- PowerShell environment preparation
- Service configuration
- Driver installation support

---

# Logging

Deployment logs are stored in the `Logs` directory.

Example:

```text
Logs\Deployment_2026-05-14.log
```

Logs assist with:
- Troubleshooting
- Deployment auditing
- Failure analysis
- Validation checks

---

# Security Notes

- Scripts should be reviewed before production use.
- Administrative privileges are required.
- Test deployments in isolated environments prior to enterprise rollout.
- Sensitive credentials should never be hardcoded into scripts or configuration files.

---

# GitHub Repository Notes

Large installer binaries are excluded from source control using `.gitignore`.

This repository is intended to store:
- automation scripts
- deployment logic
- configuration files
- documentation
- modules

Installer binaries should be maintained separately through:
- internal file shares
- package repositories
- cloud storage
- deployment servers

---

# Future Improvements

- GUI deployment launcher
- Remote deployment support
- Dynamic package downloading
- Package version management
- Enhanced validation framework
- Centralized configuration management
- SCCM / Intune integration
- Improved error handling and reporting

---

# Author

Nicholas Foreman

Systems Administrator / Infrastructure Engineer  
Infrastructure Automation & Cybersecurity Focus

---

# License

This project is provided for educational, administrative, and portfolio purposes.
Modify and distribute as needed.
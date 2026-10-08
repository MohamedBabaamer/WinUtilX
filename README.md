# WinUtilX

<p align="center">
  <img src="assets/winutilx.svg" width="112" alt="WinUtilX logo">
</p>

<h1 align="center">WinUtilX</h1>

<p align="center">
  <strong>A practical Windows utility toolbox by Mohamed Babaamer.</strong><br>
  Install applications, manage Windows settings, apply selected tweaks, troubleshoot common issues, and configure a Windows PC from one native interface.
</p>

<p align="center">
  <a href="https://github.com/MohamedBabaamer/WinUtilX/releases/latest"><img src="https://img.shields.io/github/v/release/MohamedBabaamer/WinUtilX?style=for-the-badge&label=Latest%20Release" alt="Latest release"></a>
  <a href="https://github.com/MohamedBabaamer/WinUtilX/actions/workflows/ci.yml"><img src="https://github.com/MohamedBabaamer/WinUtilX/actions/workflows/ci.yml/badge.svg?branch=main" alt="CI"></a>
  <a href="https://github.com/MohamedBabaamer/WinUtilX/releases"><img src="https://img.shields.io/github/downloads/MohamedBabaamer/WinUtilX/total?style=for-the-badge&label=Downloads" alt="Total downloads"></a>
  <a href="https://github.com/MohamedBabaamer/WinUtilX/stargazers"><img src="https://img.shields.io/github/stars/MohamedBabaamer/WinUtilX?style=for-the-badge" alt="GitHub stars"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/MohamedBabaamer/WinUtilX?style=for-the-badge" alt="MIT license"></a>
  <br>
  <img src="https://img.shields.io/badge/Windows-10%20%7C%2011-0078D4?style=flat-square&logo=windows&logoColor=white" alt="Windows 10 and 11">
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?style=flat-square&logo=powershell&logoColor=white" alt="PowerShell 5.1 and later">
</p>

<p align="center">
  <a href="https://github.com/MohamedBabaamer/WinUtilX/releases/latest"><strong>Download WinUtilX</strong></a>
  ·
  <a href="https://github.com/MohamedBabaamer/WinUtilX/releases">All releases</a>
  ·
  <a href="CHANGELOG.md">Changelog</a>
  ·
  <a href="SECURITY.md">Security policy</a>
</p>

---

## Overview

WinUtilX is an independent Windows utility toolbox based on the open-source WinUtil project. It keeps the PowerShell and native WPF foundation while adding WinUtilX branding, a refined visual theme, an expanded application catalog, release automation, and project maintenance workflows.

The goal is to make common setup and maintenance tasks easier to discover without hiding what system-level changes do.

### Features

| Area | What it provides |
|---|---|
| **Applications** | Browse and install a curated catalog of Windows applications. |
| **Windows tweaks** | Access supported privacy, performance, interface, and system settings. |
| **Fixes and configuration** | Run built-in Windows repair and configuration actions. |
| **Windows Update** | Manage supported update-related settings and operations. |
| **DNS tools** | Configure supported DNS providers. |
| **Win11 Creator** | Access Windows 11 setup and customization utilities included in the project. |
| **Presets** | Use predefined configuration options for repeatable setups. |
| **External tools** | Launch separately integrated utilities when configured. |

Features and availability depend on the selected tool, Windows version, permissions, and application metadata.

## Quick start

### Option 1 — Use the launcher

Open PowerShell on Windows and run:

```powershell
irm "https://raw.githubusercontent.com/MohamedBabaamer/WinUtilX/main/install.ps1" | iex
```

The launcher downloads the compiled script from the latest GitHub Release and starts it. If a suitable release asset is unavailable, it attempts to build from the source archive.

> **Security:** this command downloads and executes a remote PowerShell script. Read [install.ps1](install.ps1) and the source code first if you need to verify what will run. For a more cautious approach, download the release asset manually and inspect it before executing it.

### Option 2 — Download the release manually

1. Open **[WinUtilX Releases](https://github.com/MohamedBabaamer/WinUtilX/releases/latest)**.
2. Download `winutilx.ps1` and its accompanying `winutilx.ps1.sha256` checksum file.
3. Verify the checksum, then run the script from PowerShell.

```powershell
Get-FileHash .\winutilx.ps1 -Algorithm SHA256
powershell.exe -ExecutionPolicy Bypass -File .\winutilx.ps1
```

Compare the displayed hash with the hash in `winutilx.ps1.sha256`. The checksum helps verify that the downloaded file matches the published asset; it is not a digital signature.

WinUtilX needs **Administrator privileges for operations that modify system-wide Windows settings**. Review each tweak before applying it, and create a restore point before making significant system changes.

## Releases

The latest stable release is **[WinUtilX v0.1.0](https://github.com/MohamedBabaamer/WinUtilX/releases/tag/v0.1.0)**.

Release assets include the compiled WinUtilX script, SHA-256 checksum, and build metadata.

## Build from source

### Requirements

- Windows 10 or Windows 11.
- Windows PowerShell 5.1 or a compatible PowerShell installation.
- Git, if you want to clone and update the repository.

### Compile

```powershell
git clone https://github.com/MohamedBabaamer/WinUtilX.git
cd WinUtilX

# Generate the compiled script
.\Compile.ps1

# Compile and immediately launch the application
.\Compile.ps1 -Run
```

The generated `winutil.ps1` file is local build output and is intentionally not committed. Do not edit it directly; make changes to the source files and compile again.

## Application catalog

WinUtilX uses the catalog maintained in [MohamedBabaamer/apphub-data](https://github.com/MohamedBabaamer/apphub-data) as its application list.

The catalog currently contains **242 applications** in `config/applications.json`. For entries present in both catalogs, WinUtilX retains canonical metadata from its existing catalog where available. AppHub-only entries keep their supplied metadata. Package availability depends on the configured package IDs and each application's upstream distribution.

Always review an application's source and details before installing it.

## Interface and project structure

WinUtilX retains its native PowerShell/WPF architecture. The interface has refined Segoe UI typography, spacing, cards, light/dark theme resources, and clearer hover, focus, selected, and disabled states. It aims to feel more consistent while remaining lightweight; it is not a copy of another Windows utility's interface.

| Path | Purpose |
|---|---|
| `config/` | Application catalog, themes, tweaks, presets, DNS, and feature configuration |
| `functions/` | PowerShell behavior and UI logic |
| `scripts/` | Startup, compilation validation, and application startup |
| `xaml/` | Native WPF interface and styles |
| `tools/` | Supporting utilities and templates |
| `assets/` | WinUtilX visual assets |
| `.github/workflows/` | CI validation and release automation |
| `docs/` | Optional documentation source |

### Workflows

- **WinUtilX CI** — validates the JSON configuration and compiles and syntax-checks the generated PowerShell script on Windows.
- **WinUtilX Release** — builds tagged releases and creates checksum and build metadata files.
- **Dependabot** — checks GitHub Actions dependencies for updates.

See [GitHub Actions](https://github.com/MohamedBabaamer/WinUtilX/actions) for workflow history and results.

## Safety guidelines

WinUtilX can change system settings and registry values. Before using advanced or system-level options:

- Create a restore point and back up important files.
- Read the tweak description before enabling it.
- Understand possible side effects and whether a restart may be required.
- Test on a non-critical machine before relying on a configuration for production or daily use.

WinUtilX is a utility toolbox, not a replacement for a backup strategy. Third-party tools and package managers may have their own terms and security requirements.

## Contributing

Issues, bug reports, documentation improvements, and focused pull requests are welcome. Before submitting a change, compile the project and test affected behavior on Windows. Please don't commit generated `winutil.ps1` build output.

Review the [security policy](SECURITY.md) before reporting a vulnerability.

## Attribution and license

WinUtilX is based on the open-source **WinUtil** project created by **Chris Titus Tech / CT Tech Group LLC**. The WinUtilX modifications and branding are maintained by **Mohamed Babaamer**.

WinUtilX is an independent project. It is **not an official Chris Titus Tech product and is not affiliated with or endorsed by Chris Titus Tech**. The original license and required copyright notices are preserved in [LICENSE](LICENSE).

- Copyright © 2026 Mohamed Babaamer for WinUtilX modifications.
- Copyright © Chris Titus Tech / CT Tech Group LLC for original WinUtil portions.

WinUtilX is distributed under the **MIT License**. See [LICENSE](LICENSE) for the full license text.

## Maintainer

**Mohamed Babaamer**

- GitHub: [@MohamedBabaamer](https://github.com/MohamedBabaamer)
- Project: [WinUtilX](https://github.com/MohamedBabaamer/WinUtilX)

# WinUtilX

<p align="center"><img src="assets/winutilx.svg" width="120" alt="WinUtilX logo"></p>
<p align="center"><strong>A focused Windows utility toolbox for everyday users and power users.</strong><br>Install useful software, apply Windows tweaks, manage configuration, and handle common system tasks from one interface.</p>

---

## What is WinUtilX?

**WinUtilX** is Mohamed Babaamer's customized Windows toolbox based on the open-source WinUtil project.

The project keeps useful Windows administration, tweaking, installation, troubleshooting, and configuration workflows while giving the project its own focused application catalog and branding.

### WinUtilX focuses on

- Windows system utilities
- Software installation through package managers
- Windows tweaks and configuration
- System cleanup and optimization
- Network and DNS tools
- Troubleshooting and diagnostics
- Windows installation and ISO tools
- Presets and automation
- A curated application list selected for WinUtilX

## Curated Applications

WinUtilX intentionally does **not** keep the entire upstream application catalog.

The current application catalog contains **67 applications** selected from Mohamed Babaamer's personal `apphub-data` collection and matched against applications already available in the upstream catalog.

The catalog is maintained in `config/applications.json`.

`apphub-data` is used only as a reference for the curated application selection. The `apphub-data` repository itself is not modified by WinUtilX.

## Quick Start

> **Run WinUtilX as Administrator.** Some operations make system-wide Windows changes.

Open PowerShell or Windows Terminal as Administrator and run the local script:

```powershell
.\WinUtil.ps1
```

## Build

WinUtilX follows the upstream source/build structure. After changing source files, use the repository's build process to regenerate the distributable script rather than manually editing generated output.

| Path | Purpose |
|---|---|
| `config/applications.json` | WinUtilX application catalog |
| `config/tweaks.json` | Windows tweaks |
| `config/dns.json` | DNS configuration |
| `config/preset.json` | Automation presets |
| `scripts/` | PowerShell application logic |
| `xaml/` | WinUtilX graphical interface |
| `assets/` | WinUtilX branding assets |

## Design Direction

- **Name:** WinUtilX
- **Primary identity:** Windows utility / system toolbox
- **Style:** clean, technical, lightweight
- **Accent:** cyan → violet
- **Logo:** Windows-inspired four-panel mark with WinUtilX wordmark
- **Goal:** useful first, branding second

## Attribution

WinUtilX is a customized/rebranded derivative of the open-source **WinUtil** project originally created by **Chris Titus Tech / CT Tech Group LLC**.

This project is **not affiliated with, endorsed by, or an official release of Chris Titus Tech**.

The original MIT license and copyright notice are preserved in [LICENSE](LICENSE).

## License

WinUtilX is distributed under the **MIT License**. See [LICENSE](LICENSE) for the complete license text.

## Author

**Mohamed Babaamer**

GitHub: https://github.com/MohamedBabaamer

Project: https://github.com/MohamedBabaamer/WinUtilX
# The Sims 2 Setup Kit

Post-install setup tool for The Sims 2 â€” applies modern-system fixes to an **existing** installation of the Ultimate Collection, Legacy Collection, or disc version.

Companion to the [Sims 2 Setup Guide](https://voicemxil.github.io/ts2-setup-guide/).

## Disclaimer

This project is an **unofficial, fan-made tool**. It is **not affiliated with, endorsed by, or sponsored by Electronic Arts Inc. (EA)** or Maxis. "The Sims" and all associated marks are trademarks of Electronic Arts Inc.

**This tool does not contain, distribute, download, or link to game files or any means of obtaining The Sims 2.** It detects a copy of the game you already have installed and downloads community-made fixes and tools from their official sources.

## What it does

- Detects your installed version via the registry (UC/disc and Legacy register separately; if both exist, you choose)
- Installs the appropriate launcher/extender: Sims2RPC (UC/disc) or TS2 Extender (Legacy)
- Installs a modernized Graphics Rules configuration
- Installs essential community fix packages and the CEP
- Optional DXVK for modern AMD GPUs
- Sets the game language (auto-detected, changeable at setup time)

## Building

Requires [Inno Setup 6.3+](https://jrsoftware.org/isinfo.php). Open `setup.iss` in the Inno Setup Compiler, or:

```
iscc setup.iss
```

Component download URLs at the top of `setup.iss` must be finalized before a release build.

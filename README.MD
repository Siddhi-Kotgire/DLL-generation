# Automated DISCON.dll Build (Intel ifort)

This repository provides an **automated and reproducible way** to build `DISCON.dll` (ROSCO / OpenFAST controller) on **Windows** using **Intel Fortran Classic (ifort)** via **GitHub Actions**.

The same build process works **locally** (using `build.bat`) and **in the cloud** (via GitHub Actions).

---

## What this project does

* Compiles `DISCON.F90` → `DISCON.dll`
* Uses **Intel oneAPI Fortran (ifort, classic)**
* Produces a **64-bit Windows DLL**
* Statically links Intel runtime libraries
* Uploads the DLL as a GitHub Actions artifact

Designed for:

* OpenFAST
* ROSCO controller

---

## Repository contents

| File                                 | Purpose                        |
| -------------------------------------| ------------------------------ |
| `DISCON.F90`                         | Fortran controller source code |
| `build.bat`                          | Local & CI build script        |
| `.github/workflows/build-discon.yml` | GitHub Actions workflow        |
| `README.md`                          | This documentation             |

---

## Requirements (local build)

If you want to build locally on Windows:

* Windows 10 / 11 (64‑bit)
* Visual Studio 2022 (C++ Build Tools)
* Intel oneAPI **HPC Toolkit** (includes ifort)

> GitHub Actions users do **not** need local installations.

---

## Local build instructions (Windows)

1. Open **Command Prompt**
2. Navigate to the repository directory
3. Run:

```
build.bat
```

Output:

* `DISCON.dll` will be created in the same directory

---

## build.bat – what it does

High‑level steps:

1. Loads Intel oneAPI environment
2. Verifies `ifort` availability
3. Compiles `DISCON.F90` into `DISCON.dll`

Key compiler flags used:

* `/dll` → build a Windows DLL
* `/libs:static` → static Intel runtime (portable DLL)
* `/threads` → thread‑safe runtime (recommended for OpenFAST)

---

## GitHub Actions workflow

The workflow automatically builds `DISCON.dll` when:

* `DISCON.F90` is pushed to the repository, or
* the workflow is manually triggered

Workflow steps:

1. Start Windows runner
2. Install Intel oneAPI Fortran (ifort)
3. Verify compiler
4. Run `build.bat`
5. Upload `DISCON.dll` as an artifact

### Downloading the DLL

1. Go to **Actions** tab
2. Open the latest workflow run
3. Download the artifact named:

   **`DISCON-dll-ifort`**

---

## Compatibility notes

* DLL is **64‑bit**
* Works on **Intel and AMD CPUs**
* Compatible with OpenFAST / ROSCO builds expecting ifort ABI

---

## Common issues

**ifort not found**

* Ensure oneAPI is installed (local)
* Ensure `setvars.bat` is executed

**Missing Intel runtime DLLs**

* This build uses `/libs:static`, so this should not occur

**OpenFAST fails to load DLL**

* Ensure OpenFAST is also 64‑bit
* Ensure correct controller interface

---

## When to rebuild

Rebuild `DISCON.dll` when:

* `DISCON.F90` is modified
* Compiler flags are changed
* OpenFAST / ROSCO version changes

---

## Summary (quick memory hook)

> **DISCON.F90 → ifort → DISCON.dll → OpenFAST**

This setup ensures consistent, portable, and reproducible controller builds...

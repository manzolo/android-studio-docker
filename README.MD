# Android Studio Docker (with Installer Script)

A bash script to automate the installation of Android Studio, its prerequisites, and useful tools such as Fastboot and ADB. This setup also includes a Docker configuration to run Android Studio in a containerized environment.

## Inspired By
- [letsfoss/Android-Studio-Installer-Script](https://github.com/letsfoss/Android-Studio-Installer-Script)

---

## Features
- Installs prerequisites like `wget`, `git`, `qemu-kvm`, and others.
- Downloads and extracts the latest Android Studio package.
- Installs JDK 21 and sets up environment variables.
- Installs Android debugging tools (`fastboot` and `adb`).
- Configures Android Studio with a `.desktop` entry for easy access.
- Optional Docker container configuration for running Android Studio with:
  - **NVIDIA GPU acceleration** for enhanced performance.
  - **Wayland compatibility** for modern Linux display protocols.
---

## Usage

### Prerequisites
Ensure you have the following installed:
- A Linux-based operating system (e.g., Ubuntu)
- NVIDIA GPU with drivers installed
- Docker (with NVIDIA Container Toolkit) if using the containerized option
- Wayland display server (optional, for Wayland support)

### Running the Script
1. Clone the repository:
   ```bash
   git clone https://github.com/manzolo/android-studio-docker.git
   cd android-studio-docker
   chmod +x installer.sh
   ./installer.sh
   ```

## Docker Configuration

If you prefer to run Android Studio in a Docker container, a docker-compose configuration is provided.
Steps to Use Docker

Ensure Docker and Docker Compose are installed.
Build and start the container:
```bash
docker-compose up --build
```
Start the container:
```bash
docker-compose up
```
### Directory Structure

The script and Docker configuration expect the following structure for mounted directories:

```

mount/Android: For Android SDKs and files.
mount/.android: To store Android-related configurations.
mount/.AndroidStudio: To persist Android Studio settings.
mount/StudioProjects: For your Android Studio projects.
mount/.config/Google: For Google-related configurations.
mount/.gradle: To store Gradle-related data.
mount/.cache/Google: To store Google cache files.
mount/.ssh: For SSH keys.

```

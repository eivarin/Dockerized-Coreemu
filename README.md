# Dockerized-Coreemu

A dockerized image of Coreemu to easily set up and use the network emulator

# Template

To start using this Docker image, use the following template repository:  
[Dockerized-Coreemu-Template](https://github.com/eivarin/Dockerized-Coreemu-Template)

# Tested on:

| OS / Distro / WM    | Version         | Status   |
|---------------------|-----------------|----------|
| 🐧/NixOS/Hyprland      | 25 unstable     | ✅       |
<!-- | 🐧/Debian              | 12 (Bookworm)   | ✅       |
| 🐧/Fedora              | 38              | ✅       |
| 🍏/macOS               | Ventura 13      | ⚠️*     |
| 🪟/Windows (WSL2)      | 11              | ✅       | -->

<!-- *X11 forwarding may require additional configuration on macOS. -->

---
based of: [coreemu docker tutorial](https://coreemu.github.io/core/install.html#dockerfile-based-install)

## Available Images

This repository provides two Docker images:

-   `ghcr.io/eivarin/coreemu`: The base image with CORE EMU.
-   `ghcr.io/eivarin/coreemu-utils`: The base image with additional utilities (e.g., `net-tools`).

## Versioning

The images are versioned based on the CORE EMU version.

-   The base image is tagged as `ghcr.io/eivarin/coreemu:<core-emu-version>` and `ghcr.io/eivarin/coreemu:latest`.
-   The utils image is tagged as `ghcr.io/eivarin/coreemu:<core-emu-version>-utils` and `ghcr.io/eivarin/coreemu:utils`.

For example, for CORE EMU version `9.2.1`, the following images will be available:

-   `ghcr.io/eivarin/coreemu:9.2.1`
-   `ghcr.io/eivarin/coreemu:latest`
-   `ghcr.io/eivarin/coreemu:9.2.1-utils`
-   `ghcr.io/eivarin/coreemu:utils`

## Building Locally

To build the images locally, you can use Docker Buildx and the `docker-bake.hcl` file.

```bash
# Build all images
docker buildx bake

# Build a specific image
docker buildx bake core-emu

# Build the utils image
docker buildx bake utils
```

The images will be built for both `linux/amd64` and `linux/arm64` platforms.

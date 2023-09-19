# Dockerized-CoreEmu

## Requirements:
- docker
- docker-compose
- X11 display server

## Setup:
- `sh setup.sh` (This step may take a lot of time depending on your processor perfomance)

## Run:
- `./core-gui`

## NOTES/WARNINGS/TROUBLESHOUTING:
- The first time setup takes a lot of time to run. Its dependant on the speed of the processor compiling both core and EMANE
- Use the `src` folder to get code inside the container. Its path in the container is /src/. Its a volume
- You need to have the `DISPLAY` environment variable.
- you may need to check the [coreemu postinstall guide](https://coreemu.github.io/core/install.html#resolving-docker-issues)

---
based of: [coreemu docker tutorial](https://coreemu.github.io/core/install.html#dockerfile-based-install)

# Dockerized-CoreEmu

## Requirements:
- docker
- docker-compose
- X11 display server

## Setup:
- `xhost +local:root`
- `docker-compose up`

## Run the GUI:
- `docker-compose up -d` (start the backend. Not required after the first time setup)
- `docker exec -it core core-gui` (start the frontend)


## NOTES/WARNINGS/TROUBLESHOUTING:
- The first time setup takes a lot of time to run. Its dependant on the speed of the processor compiling both core and EMANE
- Use the `src` folder to get code inside the container. Its path in the container is /src/. Its a volume
- You need to have the `DISPLAY` environment variable.
- you may need to check the [coreemu postinstall guide](https://coreemu.github.io/core/install.html#resolving-docker-issues)

---
based of: [coreemu docker tutorial](https://coreemu.github.io/core/install.html#dockerfile-based-install)

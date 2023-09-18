based of: [coreemu docker tutorial](https://coreemu.github.io/core/install.html#dockerfile-based-install)

---
Requirements:
- docker
- docker-compose
- X11 display server

---
to setup:
- `xhost +local:root`
- `docker-compose up`

---
to run the GUI:
- `docker exec -it core core-gui`

---
NOTES:
- Use the `src` folder to get code inside the container. Its path in the container is /src/. Its a volume
- You need to have the `DISPLAY` environment variable.
- you may need to check the [coreemu postinstall guide](https://coreemu.github.io/core/install.html#resolving-docker-issues)
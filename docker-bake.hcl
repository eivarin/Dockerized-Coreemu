variable "CORE_EMU_VERSION" {
  default = "9.2.1"
}

variable "IMAGE_NAME" {
  default = "ghcr.io/eivarin/coreemu"
}

group "default" {
  targets = ["core-emu"]
}

target "core-emu" {
  dockerfile = "dockerfiles/Dockerfile"
  tags       = ["${IMAGE_NAME}:${CORE_EMU_VERSION}", "${IMAGE_NAME}:latest"]
  platforms  = ["linux/amd64", "linux/arm64"]
  args = {
    BRANCH = "release-${CORE_EMU_VERSION}"
  }
}
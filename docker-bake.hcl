variable "CORE_EMU_VERSION" {
  default = "9.2.1"
}

variable "IMAGE_NAME" {
  default = "ghcr.io/eivarin/coreemu"
}

group "default" {
  targets = ["core-emu", "cc25"]
}

target "core-emu" {
  dockerfile = "dockerfiles/Dockerfile.core-emu"
  tags       = ["${IMAGE_NAME}:${CORE_EMU_VERSION}", "${IMAGE_NAME}:latest"]
  platforms  = ["linux/amd64", "linux/arm64"]
  args = {
    BRANCH = "release-${CORE_EMU_VERSION}"
  }
}

target "cc25" {
  dockerfile = "dockerfiles/Dockerfile.cc25"
  tags       = ["${IMAGE_NAME}:${CORE_EMU_VERSION}-cc25", "${IMAGE_NAME}:cc25"]
  platforms  = ["linux/amd64", "linux/arm64"]
  args = {
    BASE_IMAGE = "${IMAGE_NAME}:${CORE_EMU_VERSION}"
  }
  contexts = {
    "${IMAGE_NAME}:${CORE_EMU_VERSION}" = "target:core-emu"
  }
}
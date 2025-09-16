variable "DEFAULT_TAG" {
  type    = string
  default = "ghcr.io/eivarin/coreemu:local"
}

group "default" {
  targets = ["image-local"]
}

target "docker-metadata-action" {
  tags = ["${DEFAULT_TAG}"]
}

target "image" {
  inherits = [ "docker-metadata-action" ] 
  args = {
    BRANCH = "release-9.2.1"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [ "linux/amd64", "linux/arm64" ]
}
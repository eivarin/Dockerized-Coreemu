variable "DEFAULT_TAG" {
  type    = string
  default = "ghcr.io/eivarin/dockerized-coreemu:local"
}

target "docker-metadata-action" {
  tags = ["${DEFAULT_TAG}"]
}

target "image" {
  inherits = [ "docker-metadata-action" ] 
}

group "default" {
  targets = ["image-local"]
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
}

target "ci" {
  inherits = [ "image" ]
}

target "image-all" {
  inherits = ["image"]
  platforms = [ "linux/amd64", "linux/arm64" ]
}
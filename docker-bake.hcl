variable "VERSION_TAGS" {
  type    = list(string)
  default = [ "latest" ]
}

variable "IMAGE_NAME" {
  type    = string
  default = "ghcr.io/eivarin/dockerized-coreemu"
}

function "build_tag" {
  params = [ version ]
  result = "${IMAGE_NAME}:${version}"
}

target "base" {
  context = "."
  dockerfile = "Dockerfile"
  tags = [for v in VERSION_TAGS : build_tag(v)]
}

target "ci" {
  inherits = [ "base" ]
  platforms = [ "linux/amd64", "linux/arm64" ]
}

group "default" {
  targets = [ "amd64" ]
}
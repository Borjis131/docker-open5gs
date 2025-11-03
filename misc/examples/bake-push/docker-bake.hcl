variable "OPEN5GS_VERSION" {
  default = "v2.7.6"
}

variable "UBUNTU_VERSION" {
  default = "jammy"
}

variable "NODE_VERSION" {
  default= "20"
}

variable "DOCKER_REGISTRY" {
  default = "borieher"
}

variable "GITHUB_REGISTRY" {
  default = "ghcr.io/borjis131"
}

group "default" {
  targets = ["base-open5gs", "amf", "ausf", "bsf", "nrf", "nssf",
              "pcf", "scp", "sepp", "smf", "udm", "udr", "upf", "webui"]
}

// common arguments for the containers
target "_common" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
}

target "base-open5gs" {
  inherits = ["_common"]
  context = "./images/base-open5gs"
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "base-open5gs:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=image"]
}

target "amf" {
  inherits = ["_common"]
  context = "./images/amf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/amf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/amf:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "ausf" {
  inherits = ["_common"]
  context = "./images/ausf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/ausf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/ausf:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "bsf" {
  inherits = ["_common"]
  context = "./images/bsf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/bsf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/bsf:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "nrf" {
  inherits = ["_common"]
  context = "./images/nrf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/nrf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/nrf:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "nssf" {
  inherits = ["_common"]
  context = "./images/nssf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/nssf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/nssf:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "pcf" {
  inherits = ["_common"]
  context = "./images/pcf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/pcf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/pcf:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "scp" {
  inherits = ["_common"]
  context = "./images/scp"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/scp:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/scp:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "sepp" {
  inherits = ["_common"]
  context = "./images/sepp"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/sepp:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/sepp:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "smf" {
  inherits = ["_common"]
  context = "./images/smf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/smf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/smf:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "udm" {
  inherits = ["_common"]
  context = "./images/udm"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/udm:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/udm:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "udr" {
  inherits = ["_common"]
  context = "./images/udr"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/udr:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/udr:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "upf" {
  inherits = ["_common"]
  context = "./images/upf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/upf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/upf:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "webui" {
  inherits = ["_common"]
  args = {
    NODE_VERSION = "${NODE_VERSION}"
  }
  context = "./images/webui"
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/webui:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/webui:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

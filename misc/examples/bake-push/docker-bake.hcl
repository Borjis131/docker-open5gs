variable "OPEN5GS_VERSION" {
  default = "v2.7.2"
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

target "base-open5gs" {
  context = "./images/base-open5gs"
  platforms = ["linux/amd64", "linux/arm64/v8"]
  tags = ["base-open5gs:${OPEN5GS_VERSION}"]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
}

target "amf" {
  context = "./images/amf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/ausf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/bsf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/nrf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/nssf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/pcf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/scp"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/sepp"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/smf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/udm"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/udr"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/upf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
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
  context = "./images/webui"
  platforms = ["linux/amd64", "linux/arm64/v8"]
  tags = [
    "${DOCKER_REGISTRY}/webui:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/webui:${OPEN5GS_VERSION}"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}
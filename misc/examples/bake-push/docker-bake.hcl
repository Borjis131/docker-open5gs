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

variable "FIVEG_MAG_REGISTRY" {
  default = "ghcr.io/5g-mag"
}

group "default" {
  targets = ["base-open5gs", "amf", "ausf", "bsf", "nrf", "nssf",
              "pcf", "scp", "sepp", "smf", "udm", "udr", "upf", "webui"]
}

target "base-open5gs" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/base-open5gs"
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "base-open5gs:${OPEN5GS_VERSION}",
    "base-open5gs:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=image"]
}

target "amf" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/amf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/amf:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/amf:latest",
    "${GITHUB_REGISTRY}/amf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/amf:latest",
    "${FIVEG_MAG_REGISTRY}/amf:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/amf:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "ausf" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/ausf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/ausf:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/ausf:latest",
    "${GITHUB_REGISTRY}/ausf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/ausf:latest",
    "${FIVEG_MAG_REGISTRY}/ausf:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/ausf:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "bsf" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/bsf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/bsf:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/bsf:latest",
    "${GITHUB_REGISTRY}/bsf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/bsf:latest",
    "${FIVEG_MAG_REGISTRY}/bsf:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/bsf:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "nrf" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/nrf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/nrf:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/nrf:latest",
    "${GITHUB_REGISTRY}/nrf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/nrf:latest",
    "${FIVEG_MAG_REGISTRY}/nrf:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/nrf:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "nssf" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/nssf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/nssf:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/nssf:latest",
    "${GITHUB_REGISTRY}/nssf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/nssf:latest",
    "${FIVEG_MAG_REGISTRY}/nssf:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/nssf:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "pcf" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/pcf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/pcf:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/pcf:latest",
    "${GITHUB_REGISTRY}/pcf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/pcf:latest",
    "${FIVEG_MAG_REGISTRY}/pcf:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/pcf:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "scp" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/scp"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/scp:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/scp:latest",
    "${GITHUB_REGISTRY}/scp:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/scp:latest",
    "${FIVEG_MAG_REGISTRY}/scp:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/scp:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "sepp" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/sepp"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/sepp:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/sepp:latest",
    "${GITHUB_REGISTRY}/sepp:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/sepp:latest",
    "${FIVEG_MAG_REGISTRY}/sepp:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/sepp:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "smf" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/smf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/smf:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/smf:latest",
    "${GITHUB_REGISTRY}/smf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/smf:latest",
    "${FIVEG_MAG_REGISTRY}/smf:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/smf:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "udm" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/udm"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/udm:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/udm:latest",
    "${GITHUB_REGISTRY}/udm:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/udm:latest",
    "${FIVEG_MAG_REGISTRY}/udm:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/udm:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "udr" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/udr"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/udr:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/udr:latest",
    "${GITHUB_REGISTRY}/udr:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/udr:latest",
    "${FIVEG_MAG_REGISTRY}/udr:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/udr:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "upf" {
  args = {
    UBUNTU_VERSION = "${UBUNTU_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/upf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/upf:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/upf:latest",
    "${GITHUB_REGISTRY}/upf:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/upf:latest",
    "${FIVEG_MAG_REGISTRY}/upf:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/upf:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}

target "webui" {
  args = {
    NODE_VERSION = "${NODE_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/webui"
  platforms = ["linux/amd64", "linux/arm64"]
  tags = [
    "${DOCKER_REGISTRY}/webui:${OPEN5GS_VERSION}",
    "${DOCKER_REGISTRY}/webui:latest",
    "${GITHUB_REGISTRY}/webui:${OPEN5GS_VERSION}",
    "${GITHUB_REGISTRY}/webui:latest",
    "${FIVEG_MAG_REGISTRY}/webui:${OPEN5GS_VERSION}",
    "${FIVEG_MAG_REGISTRY}/webui:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/Borjis131/docker-open5gs"
  }
  output = ["type=registry"]
}
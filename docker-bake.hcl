variable "OPEN5GS_VERSION" {
  default = "v2.7.5"
}

variable "UBUNTU_VERSION" {
  default = "jammy"
}

variable "NODE_VERSION" {
  default= "20"
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
  tags = ["base-open5gs:${OPEN5GS_VERSION}"]
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
  tags = ["amf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["ausf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["bsf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["nrf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["nssf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["pcf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["scp:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["sepp:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["smf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["udm:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["udr:${OPEN5GS_VERSION}"]
  output = ["type=image"]
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
  tags = ["upf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "webui" {
  args = {
    NODE_VERSION = "${NODE_VERSION}"
    OPEN5GS_VERSION = "${OPEN5GS_VERSION}"
  }
  context = "./images/webui"
  tags = ["webui:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}
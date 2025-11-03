variable "OPEN5GS_VERSION" {
  default = "v2.7.6"
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
  tags = ["base-open5gs:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "amf" {
  inherits = ["_common"]
  context = "./images/amf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["amf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "ausf" {
  inherits = ["_common"]
  context = "./images/ausf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["ausf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "bsf" {
  inherits = ["_common"]
  context = "./images/bsf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["bsf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "nrf" {
  inherits = ["_common"]
  context = "./images/nrf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["nrf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "nssf" {
  inherits = ["_common"]
  context = "./images/nssf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["nssf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "pcf" {
  inherits = ["_common"]
  context = "./images/pcf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["pcf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "scp" {
  inherits = ["_common"]
  context = "./images/scp"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["scp:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "sepp" {
  inherits = ["_common"]
  context = "./images/sepp"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["sepp:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "smf" {
  inherits = ["_common"]
  context = "./images/smf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["smf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "udm" {
  inherits = ["_common"]
  context = "./images/udm"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["udm:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "udr" {
  inherits = ["_common"]
  context = "./images/udr"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["udr:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "upf" {
  inherits = ["_common"]
  context = "./images/upf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["upf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "webui" {
  inherits = ["_common"]
  args = {
    NODE_VERSION = "${NODE_VERSION}"
  }
  context = "./images/webui"
  tags = ["webui:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

variable "OPEN5GS_VERSION" {
  default = "v2.7.2"
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
  context = "./images/base-open5gs"
  tags = ["base-open5gs:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "amf" {
  context = "./images/amf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["amf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "ausf" {
  context = "./images/ausf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["ausf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "bsf" {
  context = "./images/bsf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["bsf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "nrf" {
  context = "./images/nrf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["nrf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "nssf" {
  context = "./images/nssf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["nssf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "pcf" {
  context = "./images/pcf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["pcf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "scp" {
  context = "./images/scp"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["scp:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "sepp" {
  context = "./images/sepp"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["sepp:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "smf" {
  context = "./images/smf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["smf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "udm" {
  context = "./images/udm"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["udm:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "udr" {
  context = "./images/udr"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["udr:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "upf" {
  context = "./images/upf"
  contexts = {
    "base-open5gs:${OPEN5GS_VERSION}" = "target:base-open5gs"
  }
  tags = ["upf:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}

target "webui" {
  context = "./images/webui"
  tags = ["webui:${OPEN5GS_VERSION}"]
  output = ["type=image"]
}
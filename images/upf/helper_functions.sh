#!/bin/bash

# Helper functions for UPF entrypoint

# create TUN device with the name specified
# create_tun <tun_name>
function create_tun(){
    tun_name="${1}"

    ip tuntap add name ${tun_name} mode tun
    ip link set ogstun up
}

# add IP address to device
# add_ip_to_device <ip_addr> <device_name>
function add_ip_to_device(){
    ip_addr="${1}"
    device_name="${2}"

    ip address add ${ip_addr} dev ${device_name}
}

# check if it is IPv4 or IPv6
# check_ipv4_or_ipv6 <ip_addr>
function check_ipv4_or_ipv6(){
    ip_addr="${1}"

    # regex patterns for IPv4 and IPv6
    ipv4_pattern="\."
    ipv6_pattern=":"

    if [[ "${ip_addr}" =~ $ipv4_pattern ]]; then
        printf "4"
    elif [[ "${ip_addr}" =~ $ipv6_pattern ]]; then
        printf "6"
    fi
}

# takes care of everything related to TUN and NAT
# setup_subnet <ip_addr> <device>
# Note: <device> could be a valid device name or null
function setup_subnet(){
    ip_addr="${1}"
    device="${2}"

    # check TUN device exists
    ip link show dev "${device}" &> /dev/null

    # setup TUN device
    if [[ "${?}" -ne 0 ]]; then
        # if it not exists, create it and add IP address
        create_tun "${device}"
        add_ip_to_device "${ip_addr}" "${device}"
    else
        # if it exists, add IP address
        add_ip_to_device "${ip_addr}" "${device}"
    fi

    # NAT configuration section
    if [[ "${DISABLE_NAT}" != TRUE ]]; then
        # extract version of IP address provided
        ip_version="$(check_ipv4_or_ipv6 "${ip_addr}")"

        # use iptables or ip6tables depending on type
        if [[ "${ip_version}" -eq 4 ]]; then
            # check NAT rule not exists
            iptables --wait 30 -t nat -C POSTROUTING -s "${ip_addr}" ! -o "${device}" -j MASQUERADE &> /dev/null

            if [ "${?}" -ne 0 ]; then
	            # configure NAT for the subnet specified
	            iptables --wait 30 -t nat -A POSTROUTING -s "${ip_addr}" ! -o "${device}" -j MASQUERADE
            fi

        elif [[ "${ip_version}" -eq 6 ]]; then
            # check NAT rule not exists
            ip6tables-nft --wait 30 -t nat -C POSTROUTING -s "${ip_addr}" ! -o "${device}" -j MASQUERADE &> /dev/null

            if [ "${?}" -ne 0 ]; then
	            # configure NAT for the subnet specified
	            ip6tables-nft --wait 30 -t nat -A POSTROUTING -s "${ip_addr}" ! -o "${device}" -j MASQUERADE
            fi
        fi
    fi
}

# receives the Docker CMD and returns the config file path
# get_config_file_path_from_docker_cmd <docker_cmd>
function get_config_file_path_from_docker_cmd(){
    docker_cmd="${@}"

    # parse only the -c option of the Docker CMD
    arguments=($(getopt --quiet --options c: -- ${docker_cmd}))

    # if -c is present grab argument, if not default to /open5gs/install/etc/open5gs/upf.yaml
    if [[ "${arguments[0]}" != "--" ]]; then
        # remove single quotes from config file path
        config_file_path="${arguments[1]//\'/}"
    else
        # fallback to default path
        config_file_path="/open5gs/install/etc/open5gs/upf.yaml"
    fi

    printf "${config_file_path}"
}

# receives the Docker CMD and creates the interfaces needed
# setup_container_interfaces <docker_cmd>
function setup_container_interfaces(){
    # docker_cmd is "${@}"
    upf_config_file_path="$(get_config_file_path_from_docker_cmd "${@}")"

    # parse subnets from Open5GS upf.yaml config file and put it in CSV format: addr,dev
    parsed_subnets_csv="$(yq --output-format=csv '.upf.subnet[] | [ .addr, .dev ]' "${upf_config_file_path}")"

    # iterate over parsed subnets in CSV format
    for subnet_fields_csv in ${parsed_subnets_csv[@]}; do
        # split string from , delimiter and create array
        subnet_fields=(${subnet_fields_csv//,/ })

        ip_addr="${subnet_fields[0]}"
        device="${subnet_fields[1]}"

        # null devices default to ogstun
        if [[ "${device}" == "null" ]]; then
            setup_subnet "${ip_addr}" "ogstun"
        else
            setup_subnet "${ip_addr}" "${device}"
        fi
    done
}

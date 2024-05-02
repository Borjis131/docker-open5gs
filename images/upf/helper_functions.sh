#!/bin/bash

# Helper functions for UPF entrypoint

# create device with the name specified
# create_device <device_name>
function create_device(){
    device_name="${1}"

    if [[ "${ENABLE_TAP}" == "TRUE" ]]; then
        ip tuntap add name ${device_name} mode tap
    else
        ip tuntap add name ${device_name} mode tun
    fi

    ip link set ${device_name} up
}

# add IP address to device
# add_ip_to_device <subnet> <ip_addr> <device_name>
function add_ip_to_device(){
    subnet="${1}"
    ip_addr="${2}"
    device_name="${3}"

    # keep it backwards compatible
    if [[ "${ip_addr}" == "null" ]]; then
        ip address add ${subnet} dev ${device_name}
    else
        ip address add ${ip_addr} dev ${device_name}
        ip route add ${subnet} dev ${device_name}
    fi
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

# takes care of everything related to devices and NAT
# setup_subnet <subnet> <ip_addr> <device_name>
# note: <device_name> could be a valid device name or null
function setup_subnet(){
    subnet="${1}"
    ip_addr="${2}"
    device_name="${3}"

    # check if device exists
    ip link show dev "${device_name}" &> /dev/null

    # setup device
    if [[ "${?}" -ne 0 ]]; then
        # if it not exists, create it and add IP address
        create_device "${device_name}"
        add_ip_to_device "${subnet}" "${ip_addr}" "${device_name}"
    else
        # if it exists, add IP address
        add_ip_to_device "${subnet}" "${ip_addr}" "${device_name}"
    fi

    # NAT configuration section
    if [[ "${DISABLE_NAT}" != "TRUE" ]]; then
        # extract version of IP address provided
        ip_version="$(check_ipv4_or_ipv6 "${subnet}")"

        # use iptables or ip6tables depending on type
        if [[ "${ip_version}" -eq 4 ]]; then
            # check NAT rule not exists
            iptables --wait 30 -t nat -C POSTROUTING -s "${subnet}" ! -o "${device_name}" -j MASQUERADE &> /dev/null

            if [ "${?}" -ne 0 ]; then
	            # configure NAT for the subnet specified
	            iptables --wait 30 -t nat -A POSTROUTING -s "${subnet}" ! -o "${device_name}" -j MASQUERADE
            fi

        elif [[ "${ip_version}" -eq 6 ]]; then
            # check NAT rule not exists
            ip6tables-nft --wait 30 -t nat -C POSTROUTING -s "${subnet}" ! -o "${device_name}" -j MASQUERADE &> /dev/null

            if [ "${?}" -ne 0 ]; then
	            # configure NAT for the subnet specified
	            ip6tables-nft --wait 30 -t nat -A POSTROUTING -s "${subnet}" ! -o "${device_name}" -j MASQUERADE
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

    # if -c is present grab argument, if not default to /etc/open5gs/default/upf.yaml
    if [[ "${arguments[0]}" != "--" ]]; then
        # remove single quotes from config file path
        config_file_path="${arguments[1]//\'/}"
    else
        # fallback to default path
        config_file_path="/etc/open5gs/default/upf.yaml"
    fi

    printf "${config_file_path}"
}

# receives the Docker CMD and creates the interfaces needed
# setup_container_interfaces <docker_cmd>
function setup_container_interfaces(){

    # enable IPv4 forwarding
    sysctl -w net.ipv4.ip_forward=1 &> /dev/null

    # enable IPv6 forwarding
    sysctl -w net.ipv6.conf.all.forwarding=1 &> /dev/null

    # docker_cmd is "${@}"
    upf_config_file_path="$(get_config_file_path_from_docker_cmd "${@}")"

    # parse subnets from Open5GS upf.yaml config file and put it in CSV format: subnet,gateway,dev
    parsed_subnets_csv="$(yq --output-format=csv '.upf.session[] | [ .subnet, .gateway, .dev ]' "${upf_config_file_path}")"

    # iterate over parsed subnets in CSV format
    for subnet_fields_csv in ${parsed_subnets_csv[@]}; do
        # split string from , delimiter and create array
        subnet_fields=(${subnet_fields_csv//,/ })

        subnet="${subnet_fields[0]}"
        gateway="${subnet_fields[1]}"
        device_name="${subnet_fields[2]}"

        # null devices default to ogstun
        if [[ "${device_name}" == "null" ]]; then
            device_name="ogstun"
        fi

        setup_subnet "${subnet}" "${gateway}" "${device_name}"
    done
}

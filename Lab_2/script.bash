#!/bin/bash

ip_address=$1

if ! [[ $ip_address =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "IP address is not correct"
  exit 1
fi

octets=($(echo $ip_address | tr '.' ' '))

binary_ip=""
for octet in "${octets[@]}"; do
  if [ $octet -gt 255 ] || [ $octet -lt 0 ]; then
    echo "IP address is not correct"
    exit 1
  fi
  
  binary_octet=$(echo "obase=2; $octet" | bc)
  binary_octet=$(printf "%08d" $binary_octet)
  binary_ip="$binary_ip$binary_octet."
done

binary_ip=${binary_ip%.}

echo "Binary IP address: $binary_ip"

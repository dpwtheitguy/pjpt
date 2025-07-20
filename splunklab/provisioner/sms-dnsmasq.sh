#!/usr/bin/env bash
set -euo pipefail

echo 'message="Installing dnsmasq for internal DNS..."'

# Install EPEL and dnsmasq
dnf install -y epel-release || {
  echo "EPEL install failed — continuing with dnsmasq attempt"
}
dnf install -y dnsmasq

# Create DNS config directory
mkdir -p /etc/dnsmasq.d

# Define domain and static IPs
cat <<EOF > /etc/dnsmasq.d/contoso.local
domain=contoso.local
local=/contoso.local/
expand-hosts
EOF

# Add DNS records for all nodes
cat <<EOF >> /etc/dnsmasq.d/contoso.local
address=/sms.contoso.local/192.168.77.10
address=/sh1.contoso.local/192.168.77.11
address=/im1.contoso.local/192.168.77.20
address=/id1.contoso.local/192.168.77.21
address=/id2.contoso.local/192.168.77.22
address=/id3.contoso.local/192.168.77.23
address=/sl1.contoso.local/192.168.77.31
address=/lin.contoso.local/192.168.77.251
address=/puppet.contoso.local/192.168.77.20
EOF

# Enable and start dnsmasq
systemctl enable dnsmasq
systemctl start dnsmasq

# Final resolver config
echo "nameserver 192.168.77.10" > /etc/resolv.conf

echo 'message="✅ dnsmasq is running on sms with contoso.local domain"'

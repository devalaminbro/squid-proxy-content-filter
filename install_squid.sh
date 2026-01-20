```bash
#!/bin/bash

# ============================================================
# Squid Proxy Auto-Installer & Optimizer
# Author: Sheikh Alamin Santo
# Optimization: High Performance Caching & Filtering
# ============================================================

# Color Codes
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}[+] Starting Squid Proxy Installation...${NC}"

# 1. Install Squid
echo -e "${GREEN}[+] Installing Squid Cache...${NC}"
apt-get update -y
apt-get install -y squid

# 2. Backup Default Config
mv /etc/squid/squid.conf /etc/squid/squid.conf.original

# 3. Create Blocklist File
echo -e "${GREEN}[+] Creating Blocklist ACL File...${NC}"
touch /etc/squid/blocked_sites.acl
echo ".poker.com" >> /etc/squid/blocked_sites.acl
echo ".betting365.com" >> /etc/squid/blocked_sites.acl

# 4. Inject Optimized Configuration
echo -e "${GREEN}[+] Writing Optimized Configuration...${NC}"

cat > /etc/squid/squid.conf <<EOF
# --- Basic ACLs ---
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl CONNECT method CONNECT

# --- Content Filtering ACL ---
acl blocked_sites dstdomain "/etc/squid/blocked_sites.acl"

# --- Access Rules ---
http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports
http_access deny blocked_sites  # Block the bad sites
http_access allow localhost manager
http_access deny manager
http_access allow localnet      # Allow our ISP clients
http_access allow localhost
http_access deny all            # Block everything else

# --- Port Configuration ---
http_port 3128

# --- Caching Optimization ---
# Use 2GB RAM for Cache (Adjust based on Server RAM)
cache_mem 2048 MB 
maximum_object_size_in_memory 512 KB
cache_dir ufs /var/spool/squid 10000 16 256
minimum_object_size 0 KB
maximum_object_size 100 MB

# --- Logging ---
access_log daemon:/var/log/squid/access.log squid

# --- DNS Options ---
dns_v4_first on
EOF

# 5. Initialize Cache Directories
echo -e "${GREEN}[+] Initializing Cache Directories...${NC}"
service squid stop
squid -z
service squid start

# 6. Enable Service
systemctl enable squid

echo -e "${GREEN}=============================================${NC}"
echo -e "${GREEN}   PROXY SERVER INSTALLED SUCCESSFULLY! 🚀   ${NC}"
echo -e "${GREEN}=============================================${NC}"
echo -e "Port: 3128"
echo -e "Blocklist File: /etc/squid/blocked_sites.acl"

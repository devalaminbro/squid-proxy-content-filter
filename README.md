# 🛡️ Squid Proxy & Content Filter Auto-Installer

![Linux](https://img.shields.io/badge/OS-Ubuntu%20%7C%20Debian-orange)
![Service](https://img.shields.io/badge/Service-Squid%20Proxy-blue)
![Security](https://img.shields.io/badge/Security-Access%20Control-green)

## 📖 Overview
Managing what users can access on the internet is crucial for ISPs, Corporate Offices, and Educational Institutions. This repository provides a bash script to deploy a **High-Performance Squid Proxy Server**.

It configures Squid in an optimized mode to handle thousands of concurrent connections while enforcing strict **Access Control Lists (ACLs)** to block restricted content.

## 🛠 Features
- 🚫 **Content Filtering:** Automatically blocks domains listed in the blacklist file (e.g., adult, gambling).
- ⚡ **Caching:** Saves bandwidth by caching frequently visited static files (images, css, js).
- 🔒 **Access Control:** Only allows connection from trusted Local Network IPs.
- 📝 **Log Analysis:** Detailed access logs to track user activity.

## ⚙️ How It Works
1.  **ACL (Access Control List):** Defines rules for blocking/allowing traffic.
2.  **http_access:** The script sets `http_access deny blocked_sites` before allowing general traffic.
3.  **Optimization:** Tunes memory cache size for high throughput.

## 🚀 Installation Guide

### Step 1: Clone the Repo
```bash
git clone [https://github.com/devalaminbro/squid-proxy-content-filter.git](https://github.com/devalaminbro/squid-proxy-content-filter.git)
cd squid-proxy-content-filter
Step 2: Run the Installer
chmod +x install_squid.sh
sudo ./install_squid.sh

Step 3: Add Blocked Sites
Edit the blocklist file to add domains you want to stop:
nano /etc/squid/blocked_sites.acl
# Add domains like:
# .badsite.com
# .adultsite.com

Then reload squid: systemctl reload squid

⚠️ Network Config
Ensure your Router (MikroTik/Cisco) redirects web traffic (Port 80) to this server's IP (Port 3128) if you want "Transparent Proxy" mode.

Author: Sheikh Alamin Santo
Cloud Infrastructure Specialist & System Administrator

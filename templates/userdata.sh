#!/bin/bash
set -euo pipefail

# This script runs on first provisioning and whenever its hash changes.
amazon-linux-extras install -y nginx1
systemctl enable nginx
systemctl start nginx

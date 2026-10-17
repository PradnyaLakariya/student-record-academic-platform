#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IP="$(terraform -chdir="$ROOT_DIR/terraform" output -raw app_public_ip)"
cat > "$ROOT_DIR/ansible/inventory.ini" <<EOF
[student_servers]
student-host ansible_host=${IP} ansible_user=ubuntu

[student_servers:vars]
ansible_python_interpreter=/usr/bin/python3
EOF
echo "Wrote ansible/inventory.ini for ${IP}"

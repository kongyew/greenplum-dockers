#!/bin/bash
set -o nounset -o pipefail -o errexit

# Load all variables from .env and export them all for Ansible to read
set -o allexport

#source "$(dirname "$0")/.ENV"
source "$(dirname "$0")/GPDB.ENV"

set +o allexport

# Run Ansible
exec ansible-playbook "$@"
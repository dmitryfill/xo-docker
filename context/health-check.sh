#!/usr/bin/env bash

set -eo pipefail

XO_HEALTH_CHECK_PORT = ${XO_PORT:-80}

if [[ -z "$(ss -tln 2>/dev/null | grep -E "LISTEN.*:${XO_HEALTH_CHECK_PORT}" 2>/dev/null)" ]]; then
  exit 1;
fi

exit 0

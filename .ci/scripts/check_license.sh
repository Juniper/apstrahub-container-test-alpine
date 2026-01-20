#!/usr/bin/env bash

#  Copyright (c) Juniper Networks, Inc., 2025-2026.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

set -euf -o pipefail

# Check for license headers in source files
# For containers, we only need to check Dockerfile and shell scripts

ERRORS=0

check_file() {
    local file="$1"
    if ! grep -q "SPDX-License-Identifier" "$file"; then
        echo "ERROR: Missing SPDX license header in $file"
        ERRORS=$((ERRORS + 1))
    fi
}

# Check Dockerfile
if [[ -f "Dockerfile" ]]; then
    check_file "Dockerfile"
fi

# Check shell scripts
while IFS= read -r -d '' file; do
    check_file "$file"
done < <(find .ci -name "*.sh" -print0 2>/dev/null || true)

if [[ $ERRORS -gt 0 ]]; then
    echo ""
    echo "Found $ERRORS file(s) missing license headers"
    echo "Add the following header to each file:"
    echo ""
    echo "#  Copyright (c) Juniper Networks, Inc., 2025-2026."
    echo "#  All rights reserved."
    echo "#  SPDX-License-Identifier: MIT"
    exit 1
fi

echo "All files have valid license headers"

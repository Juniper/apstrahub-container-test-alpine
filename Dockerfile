#  Copyright (c) Juniper Networks, Inc., 2025-2026.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

FROM alpine:3.22

# OCI Image Labels - Required for ApstraHub container metadata extraction
LABEL org.opencontainers.image.title="ApstraHub Container Example - Alpine"
LABEL org.opencontainers.image.description="Minimal Alpine container demonstrating ApstraHub container publishing"
LABEL org.opencontainers.image.authors="ApstraHub Team <apstrahub@juniper.net>"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.documentation="https://github.com/Juniper/apstrahub-container-test-alpine"
LABEL org.opencontainers.image.source="https://github.com/Juniper/apstrahub-container-test-alpine"
LABEL org.opencontainers.image.vendor="Juniper Networks"
LABEL org.opencontainers.image.licenses="MIT"

# Keep it minimal - just echo for health check
CMD ["echo", "ApstraHub container example"]

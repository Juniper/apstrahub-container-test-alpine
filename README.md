# ApstraHub Container Example - Alpine

Minimal Alpine container demonstrating ApstraHub container publishing workflow.

## Purpose

This repository serves as a **reference example** for publishing containers to ApstraHub, demonstrating:

- GitHub Actions workflow for container build and push
- Cosign keyless signing via Sigstore/OIDC
- OCI label conventions for metadata extraction
- GitHub release with `container-url.txt` asset
- GHCR registry configuration

## Container Details

| Field | Value |
|-------|-------|
| Base Image | `alpine:3.22` |
| Version | `v1.0.0` |
| Registry | `ghcr.io/juniper/apstrahub-container-test-alpine` |
| Visibility | **Public** (required for apstrahub-publisher) |
| License | MIT |

## OCI Labels

The container includes standard OCI labels for metadata extraction:

- `org.opencontainers.image.title`: ApstraHub Container Example - Alpine
- `org.opencontainers.image.description`: Minimal Alpine container demonstrating ApstraHub container publishing
- `org.opencontainers.image.version`: 1.0.0
- `org.opencontainers.image.authors`: ApstraHub Team
- `org.opencontainers.image.source`: https://github.com/Juniper/apstrahub-container-test-alpine
- `org.opencontainers.image.licenses`: MIT

## Release Workflow

When a tag matching `v*` is pushed (e.g., `v1.0.0`):

1. Container is built from `Dockerfile`
2. Container is pushed to GitHub Container Registry (GHCR)
3. Container is signed with Cosign using key-pair (private key from GitHub secret)
4. GitHub release is created with `container-url.txt` asset

## Registry Visibility

> **Important**: The GHCR package must have **public visibility** for the apstrahub-publisher
> service to pull the container without authentication.

After the first push, set visibility in:  
GitHub → Packages → apstrahub-container-test-alpine → Settings → Change visibility → Public

## Hub Registration

Register this container in ApstraHub with key-pair Cosign verification:

```json
{
    "github_org": "Juniper",
    "github_repo": "apstrahub-container-test-alpine",
    "pack_type": "container",
    "signing_method": "cosign",
    "cosign_public_key_path": "cosign.pub"
}
```

## Local Build

```bash
docker build -t apstrahub-container-example .
docker run apstrahub-container-example
```

## Verification

```bash
# Verify Cosign signature with public key
cosign verify \
  --key cosign.pub \
  ghcr.io/juniper/apstrahub-container-test-alpine:v1.0.0
```

## GitHub Secret Setup

The private key must be stored as a GitHub secret for CI signing:

1. Go to repository **Settings → Secrets and variables → Actions**
2. Click **New repository secret**
3. Name: `COSIGN_PRIVATE_KEY`
4. Value: Paste the contents of `cosign.key` (the private key file)
5. Click **Add secret**

⚠️ **Important**: Keep `cosign.key` secure and never commit it to the repository!

## Related Documentation

- [hub_container.md](https://github.com/Juniper/aide-jcloud/blob/main/tests/dc_assurance/hub_container.md) - Container publishing design
- [hub.md](https://github.com/Juniper/aide-jcloud/blob/main/tests/dc_assurance/hub.md) - ApstraHub design

## License

MIT License - see [LICENSE](LICENSE) for details.

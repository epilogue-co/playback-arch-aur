# Playback AUR Package

Arch Linux packaging for [Playback](https://www.epilogue.co/playback), the desktop companion software for Epilogue Operator devices.

Published on the AUR as [`playback-appimage`](https://aur.archlinux.org/packages/playback-appimage).

## Generating the PKGBUILD

Run the script with a version and branch:

```bash
./generate-pkgbuild.sh <version> [branch]
```

- `version` — the Playback release version (e.g. `1.9.0`)
- `branch` — `release` (default) or `master` (nightly)

Example:

```bash
./generate-pkgbuild.sh 1.9.0 release
```

This fetches the AppImage checksums from the CDN and generates a `PKGBUILD` from the template.

## Files

- `PKGBUILD.template` — Template used to generate the final PKGBUILD
- `generate-pkgbuild.sh` — Script that fetches checksums and generates the PKGBUILD
- `playback.sh` — Wrapper script installed to `/usr/bin/playback`
- `60-gb-operator.rules` — udev rules for Epilogue Operator device access

## Publishing to AUR

1. Run `./generate-pkgbuild.sh` with the target version
2. Test the package locally (`makepkg -si`)
3. Verify Playback launches and works correctly
4. Publish the updated PKGBUILD to the AUR

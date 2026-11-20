#!/usr/bin/env python3
"""Patch the packed OS version field in an Android boot image header."""

import argparse
import struct
from pathlib import Path


def parse_triplet(value: str) -> tuple[int, int, int]:
    parts = tuple(int(part) for part in value.split("."))
    if len(parts) != 3 or any(part < 0 or part > 127 for part in parts):
        raise argparse.ArgumentTypeError("expected MAJOR.MINOR.PATCH (0..127 each)")
    return parts


def parse_security_patch(value: str) -> tuple[int, int]:
    try:
        year, month = (int(part) for part in value.split("-"))
    except ValueError as error:
        raise argparse.ArgumentTypeError("expected YYYY-MM") from error
    if year < 2000 or year > 2127 or month < 1 or month > 12:
        raise argparse.ArgumentTypeError("security patch must be 2000-01..2127-12")
    return year, month


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("image", type=Path)
    parser.add_argument("--os-version", required=True, type=parse_triplet)
    parser.add_argument("--security-patch", required=True, type=parse_security_patch)
    args = parser.parse_args()

    image = bytearray(args.image.read_bytes())
    if image[:8] != b"ANDROID!":
        raise SystemExit("not an Android boot image")

    major, minor, patch = args.os_version
    year, month = args.security_patch
    packed = (
        (major << 25)
        | (minor << 18)
        | (patch << 11)
        | ((year - 2000) << 4)
        | month
    )
    struct.pack_into("<I", image, 16, packed)
    args.image.write_bytes(image)
    print(f"patched OS field: 0x{packed:08x}")


if __name__ == "__main__":
    main()

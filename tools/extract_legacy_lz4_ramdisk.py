#!/usr/bin/env python3
"""Extract a header-v4 Android boot image's legacy-LZ4 ramdisk."""

import argparse
import struct
from pathlib import Path

import lz4.block


LEGACY_LZ4_MAGIC = 0x184C2102
LEGACY_BLOCK_SIZE = 8 * 1024 * 1024


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("image", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()

    image = args.image.read_bytes()
    if image[:8] != b"ANDROID!":
        raise SystemExit("not an Android boot image")

    ramdisk_size = struct.unpack_from("<I", image, 12)[0]
    compressed = image[4096 : 4096 + ramdisk_size]
    if struct.unpack_from("<I", compressed)[0] != LEGACY_LZ4_MAGIC:
        raise SystemExit("ramdisk is not a legacy-LZ4 stream")

    output = bytearray()
    offset = 4
    while offset + 4 <= len(compressed):
        block_size = struct.unpack_from("<I", compressed, offset)[0]
        offset += 4
        if block_size == 0:
            break
        end = offset + block_size
        output.extend(
            lz4.block.decompress(
                compressed[offset:end], uncompressed_size=LEGACY_BLOCK_SIZE
            )
        )
        offset = end

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(output)
    print(f"ramdisk={ramdisk_size} cpio={len(output)} output={args.output}")


if __name__ == "__main__":
    main()

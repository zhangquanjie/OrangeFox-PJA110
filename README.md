# OrangeFox Recovery for OnePlus Ace 2 Pro (PJA110)

Unofficial OrangeFox R11.3 device tree for PJA110 running the
`crDroidAndroid-17.0-20261118-xigua-v13.1` firmware.

## Important partition layout

PJA110 is an A/B and Virtual A/B device with a dedicated 100 MiB recovery
partition. The recovery image intentionally contains no kernel: the GKI kernel,
display, touch and other device modules are supplied by `boot` and the paired
`vendor_boot`. This tree builds `recovery.img`; it does **not** build or replace
`vendor_boot.img`.

Use the known-good `vendor_boot-20261118-recovery-fixed.img` together with the
recovery image produced here. Do not flash either image on firmware other than
the stated 2026-11-18 crDroid Android 17 build without revalidating compatibility.

## Build

The GitHub Actions workflow syncs the official OrangeFox `fox_16.0` manifest and
builds the recovery on Ubuntu 24.04. To build manually on Linux:

```bash
mkdir orangefox && cd orangefox
repo init --depth=1 -u https://gitlab.com/OrangeFox/Manifest.git -b fox_16.0
repo sync -c --force-sync --no-clone-bundle --no-tags -j4
git clone https://github.com/zhangquanjie/OrangeFox-PJA110 device/oneplus/pja110
export FOX_BUILD_DEVICE=pja110
source build/envsetup.sh
lunch twrp_pja110-bp2a-eng
mka recoveryimage -j4
```

The output is `out/target/product/pja110/recovery.img`.

## Test without flashing recovery

There is no safe `fastboot boot` path for this split recovery/vendor_boot layout.
Keep a copy of both currently working slot images before flashing. Flash only
from bootloader fastboot, and flash the matching slot explicitly:

```text
fastboot getvar current-slot
fastboot flash recovery_a OrangeFox-R11.3_1-pja110-crDroid-Android17-20261118.img
fastboot flash vendor_boot_a vendor_boot-20261118-recovery-fixed.img
fastboot reboot recovery
```

Replace `_a` with `_b` when the current slot is `b`. Initial testing should be
limited to boot, display/touch, ADB, data decryption, MTP, backup/restore and
fastbootd. Do not format or flash a ROM until those checks pass.

## Sources and license

OrangeFox is GPL-3.0-or-later. This public device tree is released under the
same license. Upstream sources are fetched unchanged from the official OrangeFox
GitLab repositories by the workflow.

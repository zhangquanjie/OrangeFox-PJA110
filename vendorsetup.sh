FDEVICE="pja110"

if [ "$1" = "$FDEVICE" ] || [ "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export FOX_BUILD_DEVICE="$FDEVICE"
    export FOX_AB_DEVICE=1
    export FOX_VIRTUAL_AB_DEVICE=1
    export FOX_VANILLA_BUILD=1
    export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
    export FOX_USE_BASH_SHELL=1
    export FOX_USE_SED_BINARY=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_NANO_EDITOR=1
    export FOX_ENABLE_APP_MANAGER=1
    export FOX_MAINTAINER_PATCH_VERSION=1
    export OF_DEFAULT_KEYMASTER_VERSION=4.1
    # Header-v4 recovery builds can populate root/vendor before the final
    # ramdisk rsync replaces it with the /vendor symlink.
    export OF_MANUAL_ROOT_VENDOR_ERROR_FIX=1
fi

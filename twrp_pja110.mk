$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)
$(call inherit-product, vendor/twrp/config/common.mk)
$(call inherit-product, device/oneplus/pja110/device.mk)

PRODUCT_DEVICE := pja110
PRODUCT_NAME := twrp_pja110
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := OnePlus Ace 2 Pro
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_RELEASE_NAME := PJA110
PRODUCT_SYSTEM_NAME := OP5943L1
PRODUCT_SYSTEM_DEVICE := OP5943L1

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="PJA110-user 17 crDroidAndroid-17.0-20261118 xigua release-keys"
BUILD_FINGERPRINT := OnePlus/PJA110/OP5943L1:17/crDroidAndroid-17.0-20261118/xigua:user/release-keys


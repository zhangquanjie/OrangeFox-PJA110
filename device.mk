LOCAL_PATH := device/oneplus/pja110

BOARD_SHIPPING_API_LEVEL := 33
PRODUCT_SHIPPING_API_LEVEL := 33
PRODUCT_TARGET_VNDK_VERSION := 34
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot-service.example_recovery \
    qcom_decrypt \
    qcom_decrypt_fbe \
    checkpoint_gc \
    f2fs_io \
    check_f2fs \
    lpflash \
    lpmake \
    lpunpack

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.qcom.rc \
    $(LOCAL_PATH)/recovery/root/system/etc/task_profiles.json:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/task_profiles.json

PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    device/qcom/twrp-common

TARGET_RECOVERY_DEVICE_DIRS += $(LOCAL_PATH)/recovery


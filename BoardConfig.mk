#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/cat/S22FLIP

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Build
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_PREBUILT_ELF_FILES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

#TARGET_USES_64_BIT_BINDER := true

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/config.fs

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := msm8937
TARGET_BOARD_PLATFORM_GPU := qcom-adreno308
TARGET_NO_BOOTLOADER := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB) 
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img 
endif

#TARGET_KERNEL_CLANG_COMPILE := true
#KERNEL_TOOLCHAIN := $(BUILD_TOP)/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin
#KERNEL_TOOLCHAIN_PREFIX := arm-linux-androideabi-

# Bootloader

BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom androidboot.memcg=true 
BOARD_KERNEL_CMDLINE += user_debug=30 msm_rtb.filter=0x237 ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += androidboot.bootdevice=7824900.sdhci 
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1 
BOARD_KERNEL_CMDLINE += earlycon=msm_hsl_uart,0x78B0000 vmalloc=300M 
BOARD_KERNEL_CMDLINE += androidboot.usbconfigfs=true cgroup.memory=nokmem,nosocket 
BOARD_KERNEL_CMDLINE += loop.max_part=7 buildvariant=user
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_SECOND_OFFSET:= 0x80000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_DTB_OFFSET := 0x101f00000
TARGET_NO_BOOTLOADER := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_KERNEL_CONFIG := S22FLIP_defconfig # no file, only make build system happy
#TARGET_KERNEL_SOURCE := $(DEVICE_PATH)/prebuilts/try
BOARD_KERNEL_IMAGE_NAME := kernel

BOARD_MKBOOTING_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTING_ARGS := --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTING_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTING_ARGS := --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_SIZE := 3336568832
BOARD_SUPER_PARTITION_GROUPS := cat_dynamic_partitions
BOARD_CAT_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    product \
    system \
    vendor
BOARD_CAT_DYNAMIC_PARTITIONS_SIZE := 3336568832

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2022-06-05

# VNDK
BOARD_VNDK_VERSION := current

# Sepolicy 
#include device/qcom/sepolicy_vndr/legacy-um/SEPolicy.mk
#SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(COMMAN_PATH)/sepolicy/private
#SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(COMMAN_PATH)/sepolicy/public
#BOARD_VENDOR_SEPOLICY_DIRS += $(COMMAN_PATH)/sepolicy/vendor

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Inherit the proprietary files
include vendor/cat/S22FLIP/BoardConfigVendor.mk

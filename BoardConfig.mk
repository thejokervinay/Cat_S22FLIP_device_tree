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

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := msm8937
TARGET_NO_BOOTLOADER := true

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Vibrator
TARGET_VIBRATOR_SUPPORTS_EFFECTS := true

# Kernel
TARGET_PREBUILT_KERNEL := true
TARGET_FORCE_PREBUILT_KERNEL := true # dont really build with our imcomplete "source"
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel # automatically copied
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img # for mkbootimg only
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img # automatically copied
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

#TARGET_KERNEL_CLANG_COMPILE := true
#TARGET_KERNEL_CONFIG := S22FLIP_defconfig # no file, only make build system happy
#KERNEL_TOOLCHAIN := $(BUILD_TOP)/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin
#KERNEL_TOOLCHAIN_PREFIX := arm-linux-androideabi-
TARGET_KERNEL_SOURCE := $(DEVICE_PATH)/prebuilts/try
BOARD_KERNEL_IMAGE_NAME := kernel

# Bootloader
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

BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200,n8 
BOARD_KERNEL_CMDLINE += androidboot.console=ttyMSM0 androidboot.hardware=qcom androidboot.memcg=true 
BOARD_KERNEL_CMDLINE += user_debug=30 msm_rtb.filter=0x237 ehci-hcd.park=3 
BOARD_KERNEL_CMDLINE += androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 
BOARD_KERNEL_CMDLINE += earlycon=msm_hsl_uart,0x78B0000 vmalloc=300M androidboot.usbconfigfs=true 
BOARD_KERNEL_CMDLINE += cgroup.memory=nokmem,nosocket loop.max_part=7 buildvariant=user
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += kpti=off

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := cat_dynamic_partitions
BOARD_CAT_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
BOARD_CAT_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

# Platform
TARGET_BOARD_PLATFORM := msm8937

# Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# VNDK
BOARD_VNDK_VERSION := current

# TWRP Configuration
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true

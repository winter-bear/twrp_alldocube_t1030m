#
# Copyright (C) 2022 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/xiaomi/yunluo

# Configure launch_with_vendor_ramdisk.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Soong Namespaces
PRODUCT_SOONG_NAMESPACES += \
	$(LOCAL_PATH)

# API
PRODUCT_SHIPPING_API_LEVEL := 31

# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# A/B
PRODUCT_PACKAGES += \
	update_engine \
	update_engine_sideload \
	update_verifier \
	checkpoint_gc

AB_OTA_POSTINSTALL_CONFIG += \
	RUN_POSTINSTALL_system=true \
	POSTINSTALL_PATH_system=system/bin/mtk_plpath_utils \
	FILESYSTEM_TYPE_system=erofs \
	POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
	RUN_POSTINSTALL_vendor=true \
	POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
	FILESYSTEM_TYPE_vendor=erofs \
	POSTINSTALL_OPTIONAL_vendor=true

# MTK Bootctrl
PRODUCT_PACKAGES += \
	android.hardware.boot@1.2-mtkimpl \
	android.hardware.boot@1.2-mtkimpl.recovery

PRODUCT_PACKAGES_DEBUG += \
	bootctrl

# Health
PRODUCT_PACKAGES += \
	android.hardware.health@2.1-impl \
	android.hardware.health@2.1-service

# MTK plpath utils
PRODUCT_PACKAGES += \
	mtk_plpath_utils \
	mtk_plpath_utils.recovery

# Keystore2
PRODUCT_PACKAGES += \
	android.system.keystore2

# Keymint
PRODUCT_PACKAGES += \
	android.hardware.security.keymint \
	android.hardware.security.secureclock \
	android.hardware.security.sharedsecret

# DRM
PRODUCT_PACKAGES += \
	android.hardware.drm@1.4

# Keymaster
PRODUCT_PACKAGES += \
	android.hardware.keymaster@4.1

# Additional Target Libraries
TARGET_RECOVERY_DEVICE_MODULES += \
	android.hardware.keymaster@4.1

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
	$(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.1.so

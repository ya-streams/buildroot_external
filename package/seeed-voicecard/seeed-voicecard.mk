SEEED_VOICECARD_VERSION = 1.0
SEEED_VOICECARD_SITE = $(BR2_EXTERNAL_YA_STREAMS_PATH)/package/seeed-voicecard
SEEED_VOICECARD_SITE_METHOD = local
SEEED_VOICECARD_INSTALL_IMAGES = YES
SEEED_VOICECARD_DEPENDENCIES = host-dtc rpi-firmware

DTC_FLAGS = -@ -b 0 -Wno-unit_address_vs_reg -I dts -O dtb
define SEEED_VOICECARD_BUILD_CMDS
	for ovldts in $(@D)/*.dts; do \
		$(HOST_DIR)/bin/dtc $(DTC_FLAGS) -o $${ovldts%.*}.dtbo $${ovldts} || exit 1; \
	done
endef

define SEEED_VOICECARD_INSTALL_IMAGES_CMDS
	for ovldtb in  $(@D)/*.dtbo; do \
		$(INSTALL) -D -m 0644 $${ovldtb} $(BINARIES_DIR)/rpi-firmware/overlays/$${ovldtb##*/} || exit 1; \
	done
endef

$(eval $(kernel-module))
$(eval $(generic-package))
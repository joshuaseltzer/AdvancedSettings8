ARCHS = armv7 armv7s arm64
THEOS_PACKAGE_DIR_NAME = packages

include theos/makefiles/common.mk

TWEAK_NAME = AdvancedSettings8
AdvancedSettings8_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Preferences"

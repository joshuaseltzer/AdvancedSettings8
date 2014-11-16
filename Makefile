ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = AdvancedSettings8
AdvancedSettings8_FILES = Tweak.xm
AdvancedSettings8_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Preferences"

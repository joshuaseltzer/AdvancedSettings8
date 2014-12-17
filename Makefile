ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = AdvancedSettings8
AdvancedSettings8_FILES = Tweak.xm
AdvancedSettings8_FRAMEWORKS = UIKit

THEOS_PACKAGE_BASE_VERSION = 1.0.1
_THEOS_INTERNAL_PACKAGE_VERSION = 1.0.1

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += advancedsettings8prefs
include $(THEOS_MAKE_PATH)/aggregate.mk

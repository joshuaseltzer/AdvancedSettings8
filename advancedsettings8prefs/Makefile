ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

BUNDLE_NAME = AdvancedSettings8Prefs
AdvancedSettings8Prefs_FILES = AdvancedSettings8Prefs.mm
AdvancedSettings8Prefs_INSTALL_PATH = /Library/PreferenceBundles
AdvancedSettings8Prefs_FRAMEWORKS = UIKit
AdvancedSettings8Prefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/AdvancedSettings8Prefs.plist$(ECHO_END)

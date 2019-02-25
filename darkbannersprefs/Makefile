include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = DarkBannersPrefs
DarkBannersPrefs_FILES = DKBRootListController.m
DarkBannersPrefs_INSTALL_PATH = /Library/PreferenceBundles
DarkBannersPrefs_FRAMEWORKS = UIKit
DarkBannersPrefs_PRIVATE_FRAMEWORKS = Preferences
DarkBannersPrefs_EXTRA_FRAMEWORKS += CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/DarkBannersPrefs.plist$(ECHO_END)

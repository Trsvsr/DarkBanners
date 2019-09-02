BOOL enabled;
BOOL oppositeMode;
BOOL dndEnabled;
BOOL enableWithDND;

static void loadPreferences() {
    CFPreferencesAppSynchronize(CFSTR("me.trsvsr.darkbannersprefs"));
    enabled = !CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("me.trsvsr.darkbannersprefs")) ? YES : [(id)CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("me.trsvsr.darkbannersprefs")) boolValue];
    oppositeMode = !CFPreferencesCopyAppValue(CFSTR("oppositeMode"), CFSTR("me.trsvsr.darkbannersprefs")) ? NO : [(id)CFPreferencesCopyAppValue(CFSTR("oppositeMode"), CFSTR("me.trsvsr.darkbannersprefs")) boolValue];
    enableWithDND = !CFPreferencesCopyAppValue(CFSTR("enableWithDND"), CFSTR("me.trsvsr.darkbannersprefs")) ? NO : [(id)CFPreferencesCopyAppValue(CFSTR("enableWithDND"), CFSTR("me.trsvsr.darkbannersprefs")) boolValue];
}

%hook DNDState
- (BOOL)isActive {
	dndEnabled = %orig;
	return %orig;
}
%end

%hook NCNotificationOptions
- (BOOL)prefersDarkAppearance {
	if (enabled) {
		if (!oppositeMode && !enableWithDND) {
			return YES;
		}
		else if (oppositeMode) {
			return NO;
		}
		else if (enableWithDND) {
			if (dndEnabled) {
				return YES;
			}
			else {
				return %orig;
			}
		}
		else {
			return %orig;
		}
	}
	else {
		return %orig;
	}
}
%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("me.trsvsr.darkbannersprefs/prefsChanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	loadPreferences();
}
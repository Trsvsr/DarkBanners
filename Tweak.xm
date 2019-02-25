BOOL enabled;
BOOL oppositeMode;

static void loadPreferences() {
    CFPreferencesAppSynchronize(CFSTR("me.trsvsr.darkbannersprefs"));
    enabled = !CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("me.trsvsr.darkbannersprefs")) ? YES : [(id)CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("me.trsvsr.darkbannersprefs")) boolValue];
    oppositeMode = !CFPreferencesCopyAppValue(CFSTR("oppositeMode"), CFSTR("me.trsvsr.darkbannersprefs")) ? NO : [(id)CFPreferencesCopyAppValue(CFSTR("oppositeMode"), CFSTR("me.trsvsr.darkbannersprefs")) boolValue];
}

%hook NCNotificationOptions
- (BOOL)prefersDarkAppearance {
	if (enabled && !oppositeMode) {
		return YES;
	}
	else if (enabled && oppositeMode) {
		return NO;
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
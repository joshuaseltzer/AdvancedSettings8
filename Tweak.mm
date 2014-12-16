//
//  Tweak.mm
//  Contains all hooks into Apple's code which handles showing the Apple internal settings.
//
//  Created by Joshua Seltzer on 12/15/14.
//
//

#import "AppleInterfaces.h"

// define the path to the preferences plist
#define kJSSettingsPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.joshuaseltzer.advancedsettings8prefs.plist"]

// define the constant for the application bundle ID that we need to check for
#define kJSAppBundleId  @"com.apple.Preferences"

// flag that determines if we have presented the advanced settings
static BOOL sJSPresentedSettings = NO;

// check the preferences file to see if the tweak itself is enabled or disabled
BOOL isEnabled()
{
    // attempt to get the preferences from the plist
    NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:kJSSettingsPath];

    // See if it we have preferences and if it is enabled.  By default it is enabled
    BOOL isEnabled = YES;
    if (prefs) {
        isEnabled = [[prefs objectForKey:@"enabled"] boolValue];
    }
    
    return isEnabled;
}

// hook to see when we long press on an icon
%hook SBIconView

// invoked when the long press timer on a Springboard icon is fired
- (void)longPressTimerFired
{
    // Check to see if the application bundle ID is equal to the settings app.  Disallow the settings
    // to display if we are already in edit mode
    if (!self.isEditing && isEnabled() && [[self.icon applicationBundleID] isEqualToString:kJSAppBundleId]) {
        // set our presentation flag to YES
        sJSPresentedSettings = YES;
        
        // show the advanced settings
        [[%c(SBPrototypeController) sharedInstance] _showSettings];
    } else {
        // perform the original implementation for any other app icon
        %orig;
    }
}

%end

// hook to see when we tap on an icon
%hook SBApplicationIcon

// launches an application
- (void)launchFromLocation:(int)location
{
    // check to see if the application bundle ID is equal to the settings app
    if (isEnabled() && [[self applicationBundleID] isEqualToString:kJSAppBundleId]) {
        if (sJSPresentedSettings) {
            // if we have presented the advanced settings, then reset the flag
            sJSPresentedSettings = NO;
        } else {
            // otherwise, launch the settings app
            %orig;
        }
    } else {
        // perform the original implementation for any other app icon
        %orig;
    }
}

%end

// hook to override the lockover variable, which allows the advanced settings to be retained on reboot
%hook SBRootSettings

// override the getter for the lockover variable
- (BOOL)preventLockover
{
    NSLog(@"************ SELTZER ************* PREVENT LOCKOVER");
    // override if the tweak is enabled
    if (isEnabled()) {
        return YES;
    } else {
        return %orig;
    }
}

// override the setter for the lockover variable
- (void)setPreventLockover:(BOOL)arg1
{
    NSLog(@"************ SELTZER ************* SET PREVENT LOCKOVER");
    // override if the tweak is enabled
    if (isEnabled()) {
        %orig(YES);
    } else {
        %orig(arg1);
    }
}

%end

/*%hook SBFAnimationFactorySettings

- (double)slowDownFactor
{
    return 0.50;
}

%end*/
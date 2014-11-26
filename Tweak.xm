// define our constants
#define kSettingsPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.joshuaseltzer.advancedsettings8prefs.plist"]
#define kAppBundleId  @"com.apple.Preferences"

// flag that determines if we have presented the advanced settings
BOOL presentedAdvancedSettings = NO;

@interface SBPrototypeController : NSObject
// the shared instance of the prototype controller
+ (id)sharedInstance;

// method that will show the controller
- (void)_showSettings;
@end

@interface SBIcon : NSObject
// return the bundle ID that corresponds to the icon
- (id)applicationBundleID;
@end

@interface SBIconView
// the corresponding SBIcon object for the SBIconView
@property(retain, nonatomic) SBIcon* icon;
@end

BOOL isEnabled()
{
    // attempt to get the preferences from the plist
    NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:kSettingsPath];

    // See if it we have preferences and if it is enabled.  By default it is enabled
    BOOL isEnabled = YES;
    if (prefs) {
        isEnabled = [[prefs objectForKey:@"enabled"] boolValue];
    }
    
    return isEnabled;
}

%hook SBIconView

// invoked when the long press timer on a Springboard icon is fired
- (void)longPressTimerFired
{
    // check to see if the application bundle ID is equal to the settings app
    if (isEnabled() && [[self.icon applicationBundleID] isEqualToString:kAppBundleId]) {
        // set our presentation flag to YES
        presentedAdvancedSettings = YES;
        
        // show the advanced settings
        [[%c(SBPrototypeController) sharedInstance] _showSettings];
    } else {
        // perform the original implementation for any other app icon
        %orig;
    }
}

%end

%hook SBApplicationIcon

// launches an application
- (void)launchFromLocation:(int)location
{
    // check to see if the application bundle ID is equal to the settings app
    if (isEnabled() && [[self applicationBundleID] isEqualToString:kAppBundleId]) {
        if (presentedAdvancedSettings) {
            // if we have presented the advanced settings, then reset the flag
            presentedAdvancedSettings = NO;
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
// string that defines the bundle ID of the settings app
static NSString *settingsBundleId = @"com.apple.Preferences";

// flag that determines if we have presented the advanced settings
BOOL presentedAdvancedSettings = NO;

@interface SBPrototypeController : NSObject
// the shared instance of the prototype controller
+ (id)sharedInstance;

// method that will show or hide the controller
- (void)showOrHide;
@end

@interface SBIcon : NSObject
// return the bundle ID that corresponds to the icon
- (id)applicationBundleID;
@end

@interface SBIconView
// the corresponding SBIcon object for the SBIconView
@property(retain, nonatomic) SBIcon* icon;
@end

%hook SBIconView

// invoked when the long press timer on a Springboard icon is fired
- (void)longPressTimerFired
{
    // check to see if the application bundle ID is equal to the settings app
    if ([[self.icon applicationBundleID] isEqualToString:settingsBundleId]) {
        // set our presentation flag to YES
        presentedAdvancedSettings = YES;
        
        // show the advanced settings
        [[%c(SBPrototypeController) sharedInstance] showOrHide];
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
    if ([[self applicationBundleID] isEqualToString:settingsBundleId]) {
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

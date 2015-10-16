//
//  AppleInterfaces
//  Contains interfaces used by the Tweak necessary to display the advanced settings.
//
//  Created by Joshua Seltzer on 12/15/14.
//
//

// the interface that defines the prototype controller itself
@interface SBPrototypeController : NSObject

// the shared instance of the prototype controller
+ (id)sharedInstance;

// method that will show the controller
- (void)_showSettings;

@end

// interface defining the icon object itself that is part of the icon view
@interface SBIcon : NSObject

// return the bundle ID that corresponds to the icon
- (id)applicationBundleID;

@end

// interface defining the view of an icon on the springboard
@interface SBIconView

// the corresponding SBIcon object for the SBIconView
@property(retain, nonatomic) SBIcon* icon;

// whether or not this icon view is currently being edited
@property(nonatomic) _Bool isEditing;

// iOS8: invoked when the long press timer on a Springboard icon is fired
- (void)longPressTimerFired;

// iOS9: fired when the second half long press is invoked
- (void)_handleSecondHalfLongPressTimer:(id)arg1;

@end
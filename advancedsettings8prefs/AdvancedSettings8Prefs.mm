#import <Preferences/Preferences.h>

@interface AdvancedSettings8PrefsListController: PSListController {
}
@end

@implementation AdvancedSettings8PrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"AdvancedSettings8Prefs" target:self] retain];
	}
	return _specifiers;
}

- (void)donate
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Q2HGCXZ5LRMMA"]];
}

@end

// vim:ft=objc

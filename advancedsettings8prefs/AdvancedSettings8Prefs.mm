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

- (void)donateToMe
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Q2HGCXZ5LRMMA"]];
}

- (void)donateToAdam
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=itswoodseiter%40bigpond%2ecom&lc=AU&item_name=AdamDevy&no_note=0&cn=Add%20special%20instructions%20to%20the%20seller%3a&no_shipping=2&currency_code=AUD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted"]];
}

@end

// vim:ft=objc

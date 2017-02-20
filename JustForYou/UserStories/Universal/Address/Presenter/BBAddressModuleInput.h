#import <Foundation/Foundation.h>

@protocol BBAddressModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parent;
- (void)popMapModuleWithAddress:(BBAddress *)address addressText:(NSString *)addressText;


@end

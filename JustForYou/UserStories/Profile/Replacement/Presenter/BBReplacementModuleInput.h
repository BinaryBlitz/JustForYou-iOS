#import <Foundation/Foundation.h>

@protocol BBReplacementModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule withType:(BBTypeReplacementController)type;
- (void)pushModuleWithNavigationModule:(id)navigationModule withType:(BBTypeReplacementController)type replacementCatgory:(NSArray *)category;

@end

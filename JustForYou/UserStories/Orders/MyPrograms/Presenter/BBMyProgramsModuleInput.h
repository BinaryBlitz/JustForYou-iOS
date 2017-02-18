#import <Foundation/Foundation.h>

#import "BBPurchases.h"

@protocol BBMyProgramsModuleInput <NSObject>

- (void)configureModule;
- (void)pushModuleWithNavigationModule:(id)navigationModule parent:(id)parent purchasesArray:(NSArray *)purchases;
- (void)popViewControllerWithStatus:(BBStatusCreateDelivery)status;
@end

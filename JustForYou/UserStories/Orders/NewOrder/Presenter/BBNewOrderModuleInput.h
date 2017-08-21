#import <Foundation/Foundation.h>

#import "BBAddress.h"

@protocol BBNewOrderModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule purchase:(BBPurchases *)purchase parentModule:(id)parent;
- (void)pushModuleWithNavigationModule:(id)navigationModule program:(BBProgram *)program parentModule:(id)parent;
- (void)pushModuleWithNavigationModule:(id)navigationModule orderProgram:(BBOrderProgram *)orderProgram program:(BBProgram *)program parentModule:(id)parent;

- (void)selectionDates:(NSArray *)array;

- (void)popAdressModuleWithAdress:(BBAddress *)address;

@end

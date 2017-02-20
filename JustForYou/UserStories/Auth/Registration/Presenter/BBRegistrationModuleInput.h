#import <Foundation/Foundation.h>

@protocol BBRegistrationModuleInput <NSObject>

- (void)configureModule;

- (void)presentWithNavigModule:(id)navigModule andUserPhone:(NSString *)phone authToken:(NSString *)authToken;

@end

#import <Foundation/Foundation.h>

@protocol BBDeliveryModuleInput;

@interface BBDeliveryAssembly : NSObject

+ (id <BBDeliveryModuleInput>)createModule;


@end

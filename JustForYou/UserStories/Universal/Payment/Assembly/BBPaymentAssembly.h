#import <Foundation/Foundation.h>

@protocol BBPaymentModuleInput;

@interface BBPaymentAssembly : NSObject

+ (id <BBPaymentModuleInput>)createModule;


@end

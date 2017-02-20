#import <Foundation/Foundation.h>

@protocol BBAddressModuleInput;

@interface BBAddressAssembly : NSObject

+ (id <BBAddressModuleInput>)createModule;


@end

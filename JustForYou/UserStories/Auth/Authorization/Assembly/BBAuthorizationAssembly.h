#import <Foundation/Foundation.h>

@protocol BBAuthorizationModuleInput;

@interface BBAuthorizationAssembly : NSObject

+ (id <BBAuthorizationModuleInput>)createModule;


@end

#import <Foundation/Foundation.h>

@protocol BBGreetingModuleInput;

@interface BBGreetingAssembly : NSObject

+ (id <BBGreetingModuleInput>)createModule;


@end

#import <Foundation/Foundation.h>

@protocol BBRegistrationModuleInput;

@interface BBRegistrationAssembly : NSObject

+ (id <BBRegistrationModuleInput>)createModule;


@end

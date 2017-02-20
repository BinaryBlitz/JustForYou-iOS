#import <Foundation/Foundation.h>

@protocol BBUniversalModuleInput;

@interface BBUniversalAssembly : NSObject

+ (id <BBUniversalModuleInput>)createModule;


@end

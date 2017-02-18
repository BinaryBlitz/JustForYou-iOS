#import <Foundation/Foundation.h>

@protocol BBNavigationModuleInput;

@interface BBNavigationAssembly : NSObject

+ (id <BBNavigationModuleInput>)createModule;


@end

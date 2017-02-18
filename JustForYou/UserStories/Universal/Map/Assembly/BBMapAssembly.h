#import <Foundation/Foundation.h>

@protocol BBMapModuleInput;

@interface BBMapAssembly : NSObject

+ (id <BBMapModuleInput>)createModule;


@end

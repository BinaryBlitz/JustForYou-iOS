#import <Foundation/Foundation.h>

@protocol BBProfileModuleInput;

@interface BBProfileAssembly : NSObject

+ (id <BBProfileModuleInput>)createModule;


@end

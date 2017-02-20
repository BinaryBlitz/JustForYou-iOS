#import <Foundation/Foundation.h>

@protocol BBReplaceProgramModuleInput;

@interface BBReplaceProgramAssembly : NSObject

+ (id <BBReplaceProgramModuleInput>)createModule;


@end

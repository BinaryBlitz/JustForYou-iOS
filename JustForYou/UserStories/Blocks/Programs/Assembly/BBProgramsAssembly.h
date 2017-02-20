#import <Foundation/Foundation.h>

@protocol BBProgramsModuleInput;

@interface BBProgramsAssembly : NSObject

+ (id <BBProgramsModuleInput>)createModule;


@end

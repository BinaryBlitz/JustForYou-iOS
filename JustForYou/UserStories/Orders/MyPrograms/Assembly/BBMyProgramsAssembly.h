#import <Foundation/Foundation.h>

@protocol BBMyProgramsModuleInput;

@interface BBMyProgramsAssembly : NSObject

+ (id <BBMyProgramsModuleInput>)createModule;


@end

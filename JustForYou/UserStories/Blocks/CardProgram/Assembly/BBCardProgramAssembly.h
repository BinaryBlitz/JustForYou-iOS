#import <Foundation/Foundation.h>

@protocol BBCardProgramModuleInput;

@interface BBCardProgramAssembly : NSObject

+ (id <BBCardProgramModuleInput>)createModule;


@end

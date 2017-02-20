#import <Foundation/Foundation.h>

@protocol BBReplacementModuleInput;

@interface BBReplacementAssembly : NSObject

+ (id <BBReplacementModuleInput>)createModule;


@end

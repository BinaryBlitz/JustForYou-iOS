#import <Foundation/Foundation.h>

@protocol BBSupportModuleInput;

@interface BBSupportAssembly : NSObject

+ (id <BBSupportModuleInput>)createModule;


@end

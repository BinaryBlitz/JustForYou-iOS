#import <Foundation/Foundation.h>

@protocol BBTabbarModuleInput;

@interface BBTabbarAssembly : NSObject

+ (id <BBTabbarModuleInput>)createModule;


@end

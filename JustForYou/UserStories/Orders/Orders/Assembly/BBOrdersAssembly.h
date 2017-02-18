#import <Foundation/Foundation.h>

@protocol BBOrdersModuleInput;

@interface BBOrdersAssembly : NSObject

+ (id <BBOrdersModuleInput>)createModule;


@end

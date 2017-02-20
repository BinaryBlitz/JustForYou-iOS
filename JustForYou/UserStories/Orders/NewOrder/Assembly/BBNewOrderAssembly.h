#import <Foundation/Foundation.h>

@protocol BBNewOrderModuleInput;

@interface BBNewOrderAssembly : NSObject

+ (id <BBNewOrderModuleInput>)createModule;


@end

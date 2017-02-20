#import <Foundation/Foundation.h>

@protocol BBBlocksModuleInput;

@interface BBBlocksAssembly : NSObject

+ (id <BBBlocksModuleInput>)createModule;


@end

#import <Foundation/Foundation.h>

@protocol BBStockModuleInput;

@interface BBStockAssembly : NSObject

+ (id <BBStockModuleInput>)createModule;


@end

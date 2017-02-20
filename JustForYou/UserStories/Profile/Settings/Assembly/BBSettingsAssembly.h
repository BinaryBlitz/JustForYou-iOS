#import <Foundation/Foundation.h>

@protocol BBSettingsModuleInput;

@interface BBSettingsAssembly : NSObject

+ (id <BBSettingsModuleInput>)createModule;


@end

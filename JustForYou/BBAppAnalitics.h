#import <Foundation/Foundation.h>

@interface BBAppAnalitics : NSObject

+ (instancetype)sharedService;

- (void)sendControllerWithName:(NSString *)name;
- (void)sendUIActionWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label;

@end

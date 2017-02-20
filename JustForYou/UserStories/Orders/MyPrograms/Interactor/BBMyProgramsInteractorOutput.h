#import <Foundation/Foundation.h>

@protocol BBMyProgramsInteractorOutput <NSObject>

- (void)errorNetwork;

- (void)currentPurchasesUserWithArray:(NSArray *)array;

@end

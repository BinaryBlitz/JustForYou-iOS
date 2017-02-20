#import <Foundation/Foundation.h>

@protocol BBReplacementInteractorOutput <NSObject>

- (void)currentReplacementInData:(NSArray *)replacement;

- (void)currentReplacementUpdate;

- (void)elemetnDidDeleteWithNewArray:(NSArray *)array;

- (void)replacementCategoryInArray:(NSArray *)categories;

- (void)errorNetwork;
- (void)errorServer;

@end

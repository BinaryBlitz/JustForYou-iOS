#import <Foundation/Foundation.h>

@class BBUser;

@protocol BBProfileInteractorOutput <NSObject>

- (void)currentUserWithUser:(BBUser *)user;

- (void)userSuccsessfulUpdate;
- (void)errorNetwork;
- (void)errorServer;

@end

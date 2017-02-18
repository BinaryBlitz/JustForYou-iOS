#import <Foundation/Foundation.h>

@class BBUser;

@protocol BBRegistrationInteractorInput <NSObject>

- (void)saveAndSendUser:(BBUser *)user;

@end

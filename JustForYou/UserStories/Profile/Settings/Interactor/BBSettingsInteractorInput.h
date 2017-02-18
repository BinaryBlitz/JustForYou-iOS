#import <Foundation/Foundation.h>

#import "BBUserService.h"

@protocol BBSettingsInteractorInput <NSObject>

- (BBUser *)currentUser;

- (void)saveUser:(BBUser *)user;

- (void)logoutUser;

@end

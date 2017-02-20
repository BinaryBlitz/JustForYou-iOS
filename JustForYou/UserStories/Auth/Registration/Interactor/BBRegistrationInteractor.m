#import "BBRegistrationInteractor.h"

#import "BBRegistrationInteractorOutput.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBRegistrationInteractor

#pragma mark - Методы BBRegistrationInteractorInput

- (void)saveAndSendUser:(BBUser *)user {
  [[BBServerService sharedService] createUserWithUser:user completion:^(BBServerResponse *response, BBUser *user, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (user) {
        [[BBUserService sharedService] saveCurrentUser:user];
        [self.output userSuccessfullySaved];
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output noConnectionNetwork];
    }
  }];
}

@end

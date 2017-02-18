#import "BBProfileInteractor.h"

#import "BBProfileInteractorOutput.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBProfileInteractor

#pragma mark - Методы BBProfileInteractorInput

- (void)updateUser {
  [[BBServerService sharedService] showUserWithUserToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, BBUser *user, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (response.serverError == kServerErrorSuccessfull) {
        [[BBUserService sharedService] updateUserWithUser:user];
        [self.output userSuccsessfulUpdate];
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output errorNetwork];
    }
  }];
}

- (void)currentUser {
  [self.output currentUserWithUser:[[BBUserService sharedService] currentUser]];
}

@end

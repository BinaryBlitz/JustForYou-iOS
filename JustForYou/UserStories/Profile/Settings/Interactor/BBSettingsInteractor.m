#import "BBSettingsInteractor.h"

#import "BBSettingsInteractorOutput.h"

#import "BBServerService.h"
#import "BBDataBaseService.h"

@implementation BBSettingsInteractor

#pragma mark - Методы BBSettingsInteractorInput

- (BBUser *)currentUser {
  return [[BBUserService sharedService] currentUser];
}

- (void)saveUser:(BBUser *)user {
  [[BBUserService sharedService] saveCurrentUser:user];
  [[BBServerService sharedService] updateUserWithUser:user apiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, BBUser *user, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (response.serverError == kServerErrorSuccessfull) {
        [self.output updateUserSuccessfully];
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output noConnectionNetwork];
    }
  }];
}

- (void)logoutUser {
  [[UIApplication sharedApplication] unregisterForRemoteNotifications];
  [[BBServerService sharedService] updateDeviceTokenWithApiToken:[[BBUserService sharedService] tokenUser] deviceToken:nil completion:^(BBServerResponse *response, NSError *error) {
  }];
  [[BBDataBaseService sharedService] deleteAllPayCardsUser];
  [self.output userLogoutSuccessfully];
}

@end

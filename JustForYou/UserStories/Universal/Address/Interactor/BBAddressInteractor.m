#import "BBAddressInteractor.h"

#import "BBAddressInteractorOutput.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBAddressInteractor

#pragma mark - Методы BBAddressInteractorInput

- (void)addAddressToUserAddressArrayWithAddressText:(BBAddress *)address {
  [[BBServerService sharedService] createAddressWithApiToken:[[BBUserService sharedService] tokenUser] address:address completion:^(BBServerResponse *response, BBAddress *address, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (response.serverError == kServerErrorSuccessfull) {
        BOOL status = [[BBUserService sharedService] addAddressToUserWithAddress:address];
        [self.output addressDidSaveWithStatus:status];
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output errorNetwork];
    }
  }];
}

@end

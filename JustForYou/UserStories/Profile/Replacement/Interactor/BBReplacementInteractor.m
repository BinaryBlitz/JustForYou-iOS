#import "BBReplacementInteractor.h"

#import "BBReplacementInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"

@implementation BBReplacementInteractor

#pragma mark - Методы BBReplacementInteractorInput

- (void)currentReplacementUser {
  NSArray *replacement = [[BBUserService sharedService] currentReplacementUser];
  [self.output currentReplacementInData:replacement];
}

- (void)addInCurrentArrayReplacementNewElement:(BBReplacementProduct *)element {
  __block BBReplacementProduct *product = element;
  [[BBServerService sharedService] createReplacementWithApiToken:[[BBUserService sharedService] tokenUser] productId:element.productId completion:^(BBServerResponse *response, NSInteger orderId, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (response.serverError == kServerErrorSuccessfull) {
        product.substId = orderId;
        [[BBUserService sharedService] updateReplasementWithProduct:product];
        [self.output currentReplacementUpdate];
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output errorNetwork];
    }
  }];
}

- (void)deleteElementInArrayWithElement:(BBReplacementProduct *)element {
  __block BBReplacementProduct *replac = element;
  [[BBServerService sharedService] deleteUserReplacementWithApiToken:[[BBUserService sharedService] tokenUser]
                                                       replacementId:[NSString stringWithFormat:@"%ld", (long) element.substId]
                                                          completion:^(BBServerResponse *response, NSError *error) {
                                                            if (response.kConnectionServer == kSuccessfullyConnection) {
                                                              if (response.serverError == kServerErrorSuccessfull) {
                                                                [self _deleteLocalReplacementWithReplacement:replac];
                                                              } else {
                                                                [self.output errorServer];
                                                              }
                                                            } else {
                                                              [self.output errorNetwork];
                                                            }
                                                          }];
}

- (void)_deleteLocalReplacementWithReplacement:(BBReplacementProduct *)element {
  NSArray *replacement = [[BBUserService sharedService] currentReplacementUser];
  NSMutableArray *newArray = [NSMutableArray arrayWithArray:replacement];
  for (BBReplacementProduct *old in replacement) {
    if (old.productId == element.productId) {
      [newArray removeObject:old];
    }
  }
  [[BBUserService sharedService] saveCurrentReplacement:newArray];
  [self.output elemetnDidDeleteWithNewArray:newArray];
}

- (void)listReplacementOnServer {
  [[BBServerService sharedService] listProductsForReplasementWithToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (response.serverError == kServerErrorSuccessfull) {
        [self.output replacementCategoryInArray:objects];
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output errorNetwork];
    }
  }];
}

@end

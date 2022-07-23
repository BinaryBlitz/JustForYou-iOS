#import "BBCardProgramInteractor.h"

#import "BBCardProgramInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"
#import "BBDataBaseService.h"

@implementation BBCardProgramInteractor

#pragma mark - Методы BBCardProgramInteractorInput

- (NSArray *)checkDaysInDataBaseWith:(NSInteger)parentId {
  return [[BBDataBaseService sharedService] daysInRealmWithParentId:parentId];
}

- (void)programInDataBaseWithParentId:(NSInteger)parentId {
  HQDispatchToMainQueue(^{
    [self.output currentProgramInDataBase:[[BBDataBaseService sharedService] programInRealmWithProgramId:parentId]];
  });
}

- (void)listDaysWithParentId:(NSInteger)parentId {
//    NSInteger __block parent = parentId;
  [[BBServerService sharedService] listDaysInProgramId:parentId apiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
    if (response.serverError == kServerErrorSuccessfull) {
      if ([objects count] > 0) {
//                HQDispatchToRealmQueue(^{
//                    [[BBDataBaseService sharedService] addOrUpdateDaysFromArray:objects parentId:parent];
        [self.output daysSaveInDataBase];
//                });
      }
    } else if (response.serverError == kServerErrorClient) {
      [self.output errorClient];
    } else if (response.serverError == kServerErrorServer) {
      [self.output errorServer];
    }
  }];
}

- (void)checkBasket {
  BBUser *user = [[BBUserService sharedService] currentUser];
  [self.output currentProgramsInBasket:user.ordersProgramArray];
}

@end

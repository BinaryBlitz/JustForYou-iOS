#import "BBListMyProgInteractor.h"

#import "BBListMyProgInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"

@implementation BBListMyProgInteractor

#pragma mark - Методы BBListMyProgInteractorInput

- (void)addInOrdersUserOrderWithProgramId:(NSInteger)programId countDay:(NSInteger)countDay {
    [[BBUserService sharedService] addOrderProgramToUserWithProgramId:programId countDays:countDay];
}

- (void)listPurchasesUser {
    [[BBServerService sharedService] listPurchasesWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (response.serverError == kServerErrorSuccessfull) {
                [self.output currentPurchasesUserWithArray:objects];
            } else {
                [self.output errorServer];
            }
        } else {
            [self.output errorNetwork];
        }
    }];
}


@end

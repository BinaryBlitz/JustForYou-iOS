#import "BBReplaceProgramInteractor.h"

#import "BBReplaceProgramInteractorOutput.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBReplaceProgramInteractor

#pragma mark - Методы BBReplaceProgramInteractorInput

- (void)listAllProgramsWithProgramId:(NSInteger)programId {
  __block NSInteger progId = programId;
  [[BBServerService sharedService] listAllProgramsWithApiToken:[[BBUserService sharedService] tokenUser]
                                                    completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
                                                      if (response.kConnectionServer == kSuccessfullyConnection) {
                                                        if (response.serverError == kServerErrorSuccessfull) {
                                                          [self removeProgramWithProgramId:progId programs:objects];
                                                        } else {
                                                          [self.output errorServer];
                                                        }
                                                      } else {
                                                        [self.output errorNetwork];
                                                      }
                                                    }];
}

- (void)removeProgramWithProgramId:(NSInteger)programId programs:(NSArray *)programs {
  NSMutableArray *result = [NSMutableArray arrayWithArray:programs];
  for (BBProgram *progr in programs) {
    if (progr.programId == programId) {
      [result removeObject:progr];
    }
  }
  [self.output allProgramsWithArray:result];
}

- (void)createReplaceWithPurchase:(BBPurchases *)purchase program:(BBProgram *)program {
  [[BBServerService sharedService] createExchangesWithApiToken:[[BBUserService sharedService] tokenUser] purchase:[NSString stringWithFormat:@"%ld", (long) purchase.purchasesId] program:[NSNumber numberWithInteger:program.programId] completion:^(BBServerResponse *response, BBExchange *exchange, NSData *data, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (response.serverError == kServerErrorSuccessfull) {
        [self.output exchangeDidCreate:exchange];
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output errorNetwork];
    }
  }];
}

- (void)payWithExchange:(BBExchange *)exchange card:(BBPayCard *)card {
  [[BBServerService sharedService] payExchangeWithApiToken:[[BBUserService sharedService] tokenUser] exchange:exchange payId:card.payCardId completion:^(BBServerResponse *response, NSData *data, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (response.serverError == kServerErrorSuccessfull) {
        id Obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSInteger payId = [[Obj valueForKey:@"id"] integerValue];
        NSString *payUrl = [Obj valueForKey:@"payment_url"];
        BOOL paid = [[Obj valueForKey:@"paid"] boolValue];
        if (paid) {
          [self.output paymentSuccessfull];
        } else {
          [self.output exchangeWithPayId:payId payURL:payUrl];
        }
      } else if (response.responseCode == 422) {
        [self.output paymentSuccessfull];
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output errorNetwork];
    }
  }];
}

@end

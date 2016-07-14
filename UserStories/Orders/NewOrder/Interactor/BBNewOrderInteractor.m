//
//  BBNewOrderInteractor.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderInteractor.h"

#import "BBNewOrderInteractorOutput.h"

#import "BBServerService.h"
#import "BBUserService.h"
#import "BBCalendarService.h"
#import "BBDataBaseService.h"

@implementation BBNewOrderInteractor

#pragma mark - Методы BBNewOrderInteractorInput

- (void)createDeliveryOnServerWithDays:(NSArray *)days address:(BBAddress *)address purchase:(BBPurchases *)purchase coment:(NSString *)coment {
    NSMutableArray *arrayForTransport = [NSMutableArray array];
    for (NSDate *date in days) {
        NSString *dat = [[BBCalendarService sharedService] stringForDate:date];
        NSDictionary *params = @{@"scheduled_for" : dat,
                                 @"address_id"    : [NSNumber numberWithInteger:address.addressId],
                                 @"comment"       : coment};
        [arrayForTransport addObject:params];
    }
    [[BBServerService sharedService] createDeliveriesWithApiToken:[[BBUserService sharedService] tokenUser]
                                                          purchId:[NSString stringWithFormat:@"%ld", (long)purchase.purchasesId]
                                                  arrayDeliveries:arrayForTransport completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
                                                      if (response.kConnectionServer == kSuccessfullyConnection) {
                                                          if (response.serverError == kServerErrorSuccessfull) {
                                                              HQDispatchToMainQueue(^{
                                                                  [[BBDataBaseService sharedService] addOrUpdateOrdersFromArray:objects callback:^{
                                                                      [self.output deliveriesCreateSuccessfull];
                                                                  }];
//                                                                  [[BBDataBaseService sharedService] addOrUpdateOrdersFromArray:objects];
                                                              });
                                                          } else {
                                                              [self.output errorServer];
                                                          }
                                                      } else {
                                                          [self.output errorNetwork];
                                                      }
        
    }];
}


@end
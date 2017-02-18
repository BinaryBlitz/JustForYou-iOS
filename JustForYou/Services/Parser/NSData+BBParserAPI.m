#import "NSData+BBParserAPI.h"

#import "BBBlock.h"
#import "BBProgram.h"
#import "BBDay.h"

#import "BBDataBaseService.h"
#import "BBUserService.h"

@implementation NSData (BBParserAPI)

#pragma mark - User Methods

- (NSString *)parseAuthorizateToken {
  return [[NSJSONSerialization JSONObjectWithData:self options:0 error:nil] objectForKey:@"token"];
}

- (NSString *)parseApiToken {
  return [[NSJSONSerialization JSONObjectWithData:self options:0 error:nil] objectForKey:@"api_token"];
}

- (BBUser *)parseRegisterResponseWithData {
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  BBUser *user = nil;
  if ([JSONObj count] > 1) {
    user = [[BBUser alloc] initWithJSON:JSONObj];
    NSString *apiToken = [JSONObj valueForKey:@"api_token"];
    if (apiToken) {
      [[BBUserService sharedService] saveUserApiToken:apiToken];
    }
  }
  return user;
}

- (NSArray *)parseUserAddressWithData {
  NSMutableArray *result = [NSMutableArray array];
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  if ([JSONObj isKindOfClass:[NSArray class]]) {
    for (id obj in JSONObj) {
      BBAddress *address = [[BBAddress alloc] initWithJSON:obj];
      [result addObject:address];
    }
  }
  return result;
}

#pragma mark - Blocks And Program Methods

- (NSArray *)parseArrayWithDataAndKey:(BBTypeObjectInData)key parentId:(NSInteger)parentId {
  NSMutableArray *result = [NSMutableArray array];
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  if ([JSONObj isKindOfClass:[NSArray class]]) {
    for (id obj in JSONObj) {
      if (key == kTypeBlockInData) {
        BBBlock *block = [[BBBlock alloc] initWithJSON:obj];
        [result addObject:block];
      } else if (key == kTypeProgramInData) {
        BBProgram *program = [[BBProgram alloc] initWithJSON:obj];
        program.parentId = parentId;
        [result addObject:program];
      } else {
        [result addObject:obj];
      }
    }
    if (key == kTypeDayInData) {
      if ([result count] > 0) {
        HQDispatchToMainQueue(^{
          [[BBDataBaseService sharedService] addOrUpdateDaysFromArray:result parentId:parentId];
        });
      }
    }
  }
  return result;
}

#pragma mark - Orders Methods

- (NSInteger)parseCreatingOrderPrograms {
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  return [[JSONObj objectForKey:@"id"] integerValue];
}

- (NSArray *)parseOrderListWithData {
  NSMutableArray *result = [NSMutableArray array];
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  if ([JSONObj isKindOfClass:[NSArray class]]) {
    for (id obj in JSONObj) {
      id programs = [obj valueForKey:@"programs"];
      if ([programs isKindOfClass:[NSArray class]]) {
        for (id prog in programs) {
          BBProgramHistory *history = [[BBProgramHistory alloc] initWithJSON:obj program:prog];
          [result addObject:history];
        }
      }
    }
  }
  return result;
}

#pragma mark - Deliveries Methods

- (NSArray *)parsePurchasesWithData {
  NSMutableArray *result = [NSMutableArray array];
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  if ([JSONObj isKindOfClass:[NSArray class]]) {
    NSInteger count = 0;
    for (id obj in JSONObj) {
      BBPurchases *purchases = [[BBPurchases alloc] initWithJSON:obj];
      [result addObject:purchases];
      count++;
    }
    BBUser *user = [[BBUserService sharedService] currentUser];
    user.countPurchases = count;
    [[BBUserService sharedService] saveCurrentUser:user];
  }
  return result;
}

- (NSArray *)parseDeliveriesWithData {
  NSMutableArray *result = [NSMutableArray array];
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  if ([JSONObj isKindOfClass:[NSArray class]]) {
    for (id obj in JSONObj) {
      BBOrder *order = [[BBOrder alloc] initWithJSON:obj];
      [result addObject:order];
    }
  }
  return result;
}

#pragma mark - Payments Methods

- (BBPayment *)parsePaymentWithData {
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  BBPayment *payment = [[BBPayment alloc] initWithJSON:JSONObj];
  return payment;
}

- (BOOL)parsePaymentInCardWithData {
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  BOOL paid = NO;
  paid = [[JSONObj objectForKey:@"paid"] boolValue];
  return paid;
}

#pragma mark - Stock Methods

- (NSArray *)parseStocksWithData {
  NSMutableArray *result = [NSMutableArray array];
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  if ([JSONObj isKindOfClass:[NSArray class]]) {
    for (id obj in JSONObj) {
      BBStock *address = [[BBStock alloc] initWithJSON:obj];
      [result addObject:address];
    }
  }
  return result;
}

#pragma  mark - PayCard Methods 

- (NSArray *)parsePaymentsCardUserWithData {
  NSMutableArray *result = [NSMutableArray array];
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  if ([JSONObj isKindOfClass:[NSArray class]]) {
    for (id obj in JSONObj) {
      BBPayCard *card = [[BBPayCard alloc] initWithJSON:obj];
      [result addObject:card];
    }
  }
  return result;
}

#pragma mark - Replacement Methods

- (NSArray *)parseProductsForReplacementWithData {
  NSMutableArray *result = [NSMutableArray array];
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  if ([JSONObj isKindOfClass:[NSArray class]]) {
    for (id obj in JSONObj) {
      BBReplacementCategory *card = [[BBReplacementCategory alloc] initWithJSON:obj];
      [result addObject:card];
    }
  }
  return result;
}

- (NSArray *)parseUserReplacementWithData {
  NSMutableArray *result = [NSMutableArray array];
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  if ([JSONObj isKindOfClass:[NSArray class]]) {
    for (id obj in JSONObj) {
      id json = [obj objectForKey:@"product"];
      NSInteger substId = [[obj valueForKey:@"id"] integerValue];
      BBReplacementProduct *card = [[BBReplacementProduct alloc] initWithJSON:json];
      card.substId = substId;
      [result addObject:card];
    }
  }
  return result;
}

#pragma mark - Exchanges Methods

- (NSArray *)parseAllProgramsWithData {
  NSMutableArray *result = [NSMutableArray array];
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  if ([JSONObj isKindOfClass:[NSArray class]]) {
    for (id obj in JSONObj) {
      BBProgram *program = [[BBProgram alloc] initWithJSON:obj];
      program.parentId = [[obj valueForKey:@"block_id"] integerValue];
      [result addObject:program];
    }
  }
  return result;
}

- (BBExchange *)parseExchangeWithData {
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  BBExchange *exchange = [[BBExchange alloc] initWithJSON:JSONObj];
  return exchange;
}

#pragma mark - Address Methods 

- (BBAddress *)parseAddressWithData {
  id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
  BBAddress *address = [[BBAddress alloc] initWithJSON:JSONObj];
  return address;
}

#pragma mark - Map Methods

- (id)parseSearchAddress {
  return [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];;
}

@end
